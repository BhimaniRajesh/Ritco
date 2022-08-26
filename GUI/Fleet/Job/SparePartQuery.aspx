<%@ Page Language="C#" AutoEventWireup="true"  MasterPageFile="~/GUI/MasterPage.master"       CodeFile="SparePartQuery.aspx.cs" Inherits="GUI_Fleet_Job_SparePartQuery" %>
<%@ Register TagName="DT" TagPrefix="Date" Src="~/GUI/Common_UserControls/RPT_Date.ascx" %>
  <asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server" >
  <script src="../../images/CalendarPopup.js"  language="javascript" type="text/javascript"></script>
    <script language="javascript" type="text/javascript">
        var cal = new CalendarPopup("testdiv1"); 
        cal.setCssPrefix("TEST");
        cal.showNavigationDropdowns();
function lnkbtnXLS_Click()
    {
      window.open("SparePartReport.aspx","");
    }
     function lnkbtnView_Click()
    {
    
     window.open('SparePartReport.aspx','new_win','width=700,height=500,scrollbars=yes');
      //window.open("GeneralTaskReport.aspx","");
    }
    function lnkbtnPrint_Click()
    {
      window.open("SparePartReport.aspx?print=0','new_win','width=600,height=500,scrollbars=yes");
      //window.open("GeneralTaskReport.aspx","");
    }
    </script>
      <div id="testdiv1" style="position: absolute; visibility: hidden; background-color: white;
        layer-background-color: white; z-index: 99;">
    </div>
    <!--End of asp Script Manager -->
    <table cellspacing="1" style="width: 100%">
        <tr style="background-color: white">
            <td align="left">
                <asp:Label ID="lblPageHead" runat="server" CssClass="blackfnt" Font-Bold="True">Spare Part Master</asp:Label>
                <hr align="center" color="#8ba0e5" size="1" />
            </td>
                   <td align="right">
                <asp:UpdateProgress ID="UpdateProgress1" runat="server" >
                    <ProgressTemplate>
                    <asp:Image ID="img1" runat="server" ImageUrl="~/GUI/images/indicator.gif" />
                    <font class="blackfnt" color="red"><b>Please wait...</b></font>
            </ProgressTemplate>
          </asp:UpdateProgress>  
         
          </td>      
            
            
            
        </tr>
    </table>
 <table cellspacing="1" style="width: 100%">
     <tr align="center">
            <td>
                <table cellspacing="1" style="width: 70%">
                    <tr style="background-color: white">
                        <td align="left">
                            <asp:Label ID="lblNew" runat="server" CssClass="blackfnt" Font-Bold="true" Text="New ?? "></asp:Label>
                            <asp:LinkButton ID="lnkCreateDriver" runat="server" Text="Add Spare Part" CssClass="bluefnt" Font-Bold="true" PostBackUrl="~/GUI/Fleet/Job/SparePartMaster.aspx"  ValidationGroup="VGCreate"></asp:LinkButton>    
                        </td>
                         <td align="left" colspan="2" style="height: 26px; text-align: right">
                            <asp:UpdatePanel runat="server" ID="UpdatePanel2">
                            <ContentTemplate>
                      
                            <asp:LinkButton ID="lnkbtnView" runat="server" OnClientClick="Javascript: return lnkbtnView_Click();"  CssClass="bluefnt" Font-Bold="True">View</asp:LinkButton>
                                <asp:Label ID="Label2" runat="server" Text="|"></asp:Label>
                                <asp:LinkButton ID="lnkbtnPrint" runat="server" OnClientClick="Javascript: return lnkbtnPrint_Click();"  CssClass="bluefnt" Font-Bold="True">Print</asp:LinkButton>
                            </ContentTemplate>
                        </asp:UpdatePanel>
                        </td>
                        <td align="left" style="width: 7px; height: 26px">
                            <asp:Label ID="Label3" runat="server" Text="|"></asp:Label></td>
                        <td align="left" style="width: 7px; height: 26px;">
                            <asp:LinkButton ID="lnkbtnXLS" runat="server" OnClientClick="Javascript: return lnkbtnXLS_Click();" CssClass="bluefnt" Font-Bold="True">XLS</asp:LinkButton></td>
                    
                    </tr>
                </table>
            </td>
        </tr>
        <tr align="center">
            <td>
                <table cellspacing="1" style="width: 70%" class="boxbg">
                    <tr class="bgbluegrey">
                        <td colspan="3" align="center">
                            <asp:Label ID="lblQry" CssClass="blackfnt" Font-Bold="true" runat="server">Search Criteria</asp:Label>
                        </td>
                    </tr>
                  
                    <tr style="background-color: white">
                        <td align="right">
                            <asp:Label ID="lblDateRange1" CssClass="blackfnt" runat="server" Font-Bold="true">
                                Part Added in Date Range:
                            </asp:Label>
                        </td>
                        <td align="left" colspan="2">
                        <%--    <asp:UpdatePanel ID="UpdatePanel1" Mode="Conditional" RenderMode="Inline" runat="server">
                                <ContentTemplate>
                                    <asp:RadioButtonList ID="radDate" runat="server" ValidationGroup="VGDtFromTo" CssClass="blackfnt"
                                        AutoPostBack="true" OnSelectedIndexChanged="radDate_OnSelectedIndexChange">
                                        <asp:ListItem Selected="True" Value="0" Text=" Date Range [dd/mm/yyyy]"></asp:ListItem>
                                        <asp:ListItem Selected="false" Value="1" Text=" Last Week (Including Today)"></asp:ListItem>
                                        <asp:ListItem Selected="false" Value="2" Text=" Today:"></asp:ListItem>
                                        <asp:ListItem Selected="false" Value="3" Text=" Till Date:"></asp:ListItem>
                                    </asp:RadioButtonList>
                                </ContentTemplate>
                            </asp:UpdatePanel>--%>
                            <Date:DT ID="DT" EnableTillDate="true" runat="server" />
                        </td>
                      <%--  <td valign="top" align="left">
                            <asp:UpdatePanel ID="UpdatePanel2" RenderMode="Inline" Mode="Conditional" runat="server">
                                <ContentTemplate>
                                    <asp:Label ID="lblFrom" CssClass="blackfnt" runat="server" Text=" From: "></asp:Label>
                                    <asp:TextBox ID="txtDateFrom" runat="Server" ValidationGroup="VGDtFromTo" Width="80"></asp:TextBox>
                                    <asp:Label ID="lblTo" CssClass="blackfnt" runat="server" Text=" To: "></asp:Label>
                                    <asp:TextBox ID="txtDateTo" runat="Server" ValidationGroup="VGDtFromTo" Width="80"></asp:TextBox>
                                    </br>
                                    <asp:RequiredFieldValidator ID="RFVFromDate" runat="server" ControlToValidate="txtDateFrom"
                                        ErrorMessage="Date From cannot be blank :(" CssClass="blackfnt" ValidationGroup="VGDtFromTo" />
                                    </br>
                                    <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ErrorMessage="Invalid Date From  :("
                                        ControlToValidate="txtDateFrom" ValidationGroup="VGDtFromTo" ValidationExpression="(((0[1-9]|[12][0-9]|3[01])([-./])(0[13578]|10|12)([-./])(\d{4}))|(([0][1-9]|[12][0-9]|30)([-./])(0[469]|11)([-./])(\d{4}))|((0[1-9]|1[0-9]|2[0-8])([-./])(02)([-./])(\d{4}))|((29)(\.|-|\/)(02)([-./])([02468][048]00))|((29)([-./])(02)([-./])([13579][26]00))|((29)([-./])(02)([-./])([0-9][0-9][0][48]))|((29)([-./])(02)([-./])([0-9][0-9][2468][048]))|((29)([-./])(02)([-./])([0-9][0-9][13579][26])))"></asp:RegularExpressionValidator>
                                    </br>
                                    <asp:RequiredFieldValidator ID="RFVToDate" runat="server" ControlToValidate="txtDateTo"
                                        ErrorMessage="Date To cannot be blank :(" CssClass="blackfnt" ValidationGroup="VGDtFromTo" />
                                    </br>
                                    <asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server" ErrorMessage="Invalid Date To  :("
                                        ControlToValidate="txtDateTo" ValidationGroup="VGDtFromTo" ValidationExpression="(((0[1-9]|[12][0-9]|3[01])([-./])(0[13578]|10|12)([-./])(\d{4}))|(([0][1-9]|[12][0-9]|30)([-./])(0[469]|11)([-./])(\d{4}))|((0[1-9]|1[0-9]|2[0-8])([-./])(02)([-./])(\d{4}))|((29)(\.|-|\/)(02)([-./])([02468][048]00))|((29)([-./])(02)([-./])([13579][26]00))|((29)([-./])(02)([-./])([0-9][0-9][0][48]))|((29)([-./])(02)([-./])([0-9][0-9][2468][048]))|((29)([-./])(02)([-./])([0-9][0-9][13579][26])))"></asp:RegularExpressionValidator>
                                </ContentTemplate>
                                <Triggers>
                                    <asp:ControlEventTrigger ControlID="radDate" EventName="SelectedIndexChanged" />
                                </Triggers>
                            </asp:UpdatePanel>
                        </td>--%>
                    </tr>
                    
                 <%--   <tr style="background-color: white">
                        <td align="right" style="height: 27px">
                            <asp:Label ID="lbldriverName" Text="Part Description " Font-Bold="true" CssClass="blackfnt"
                                runat="server" />
                        </td>
                        <td colspan="2" align="left" style="height: 27px">
                            <asp:TextBox ID="txtPartName" runat="server"  >
                             
                            </asp:TextBox>
                           
                          
                        </td>
                    </tr>--%>


  


                    <tr style="background-color: white">
                        <td colspan="3" align="right">
                            <asp:UpdatePanel ID="UPShowDriver" UpdateMode="Conditional" RenderMode="Inline" runat="server">
                                <ContentTemplate>
                                    <asp:Button ID="btnShowParts" runat="server" Text="Show Spare Parts(s) >>" ValidationGroup="VGDtFromTo" OnClick="btnShowParts_Click" 
                                        />
                                    <asp:UpdateProgress runat="server" ID="Prog1">
                                        <ProgressTemplate>
                                            <asp:Image ID="imgWait" ImageUrl="~/GUI/images/indicator.gif" runat="server" BorderStyle="none" />
                          
                                        </ProgressTemplate>
                                    </asp:UpdateProgress>
                         
                                </ContentTemplate>
                            </asp:UpdatePanel>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
       
    </table>
   <br />
   <p align="center">
   <table cellspacing="1" style="width: 100%">
        <tr align="center">
            <td align="center">
                <asp:UpdatePanel ID="u1" UpdateMode="Conditional" runat="server">
                    <ContentTemplate>
                   <%-- DataSourceID="ObjectDataSource1" EnableViewState="False"--%>
                        <asp:GridView ID="dgPart" runat="server" BorderWidth="1px" CellSpacing="1" CellPadding="5" HeaderStyle-CssClass="dgHeaderStyle" 
                             AllowPaging="True" PageSize="50" PagerStyle-HorizontalAlign="left"               
                            PagerSettings-Mode="Numeric" AutoGenerateColumns="False"
                            CssClass="dgRowStyle" EmptyDataText="No Records Found..." BorderColor="#8BA0E5" OnPageIndexChanging="pgChange" OnRowCommand="dg_RowCommand" DataKeyNames="Part_ID">
                            <Columns>
                                <asp:HyperLinkField DataTextFormatString="--Select--" DataTextField="Part_ID" DataNavigateUrlFields="Part_ID"
                                    DataNavigateUrlFormatString="~/GUI/Fleet/Job/SparePartMaster.aspx?id={0}" >
                                    <ItemStyle CssClass="bluelink" ForeColor="Blue" />
                                </asp:HyperLinkField>
                                <asp:BoundField DataField="W_GrpDesc" HeaderText="Work Group" >
                                    <ItemStyle HorizontalAlign="Left" />    
                                    <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                </asp:BoundField>
                                
                                  <asp:BoundField DataField="TaskType" HeaderText="Task Type" >
                                    <ItemStyle HorizontalAlign="Left" />    
                                    <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                </asp:BoundField>
                                
                               <asp:BoundField DataField="Description" HeaderText="Part Description" >
                                    <ItemStyle HorizontalAlign="Left" />    
                                    <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                </asp:BoundField>
                               
                                <asp:BoundField DataField="Unit_Of_Inventory" HeaderText="Unit Of Inventory"> 
                                    <ItemStyle HorizontalAlign="Left" />    
                                      <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                </asp:BoundField>
                                

                                <asp:BoundField DataField="Avg_Cost" HeaderText="Avg.Cost">
                                    <ItemStyle HorizontalAlign="Left" />    
                                    <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                </asp:BoundField>
                                
                                <asp:BoundField DataField="Selling_Price" HeaderText="Selling Price">
                                    <ItemStyle HorizontalAlign="Left" />    
                                    <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                </asp:BoundField>
                                           <%--  <asp:BoundField DataField="Driver_Status" HeaderText="Driver Status" >
                                    <ItemStyle HorizontalAlign="Right" />
                                    <HeaderStyle HorizontalAlign="Center" Wrap="False" />
                                </asp:BoundField>    --%>                                             
                               <asp:BoundField DataField="Reorder_Point" HeaderText="Reorder Point">
                                    <ItemStyle HorizontalAlign="Left" />
                                    <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                </asp:BoundField>     
                                 <asp:BoundField DataField="Reorder_Qty" HeaderText="Reorder Quantity">
                                    <ItemStyle HorizontalAlign="Left" />
                                    <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                </asp:BoundField>  
                                
                                
                                
                                <asp:BoundField DataField="ExpDt1" HeaderText="Expiry Date">
                                    <ItemStyle HorizontalAlign="Left" />
                                    <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                </asp:BoundField>     
                                 <asp:BoundField DataField="ExpKms" HeaderText="Expiry Kms">
                                    <ItemStyle HorizontalAlign="Left" />
                                    <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                </asp:BoundField>  
                                
                             
                                                     
                            
                                
                                <asp:TemplateField>
                                 <ItemTemplate>
                                    <asp:LinkButton ID="DeleteButton" runat="server" CausesValidation="False" 
                                        Text="X" OnClientClick="return confirm('Are you certain that you want to delete this record?');">
                                    </asp:LinkButton>
                                 </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                            <RowStyle BorderColor="Black" BorderStyle="None" BorderWidth="1px" />
                            <PagerStyle HorizontalAlign="Left" />
                            <HeaderStyle CssClass="dgHeaderStyle" />
                        </asp:GridView>
                        
                    </ContentTemplate>
                    <Triggers>
                        <asp:AsyncPostBackTrigger ControlID="btnShowParts" EventName="Click" />
                    </Triggers>
                </asp:UpdatePanel>
                </td>
        </tr>
    </table>
   </p>
 
 </asp:Content>
