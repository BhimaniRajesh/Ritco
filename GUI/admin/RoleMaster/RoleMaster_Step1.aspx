<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true"
    CodeFile="RoleMaster_Step1.aspx.cs" Inherits="GUI_admin_RoleMaster_RoleMaster_Step1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">

    <script language="javascript" type="text/javascript" src="../../images/CalendarPopup.js"> </script>

    <script language="javascript" type="text/javascript" src="../../images/commonJs.js"></script>

    <script language="javascript" type="text/javascript">
 
 var ROLE_str="<%=ROLE_str%>"
var roleid="<%=roleid%>"
    function Rolecheck(obj)
{
   // alert(loccodeval)
   //alert(cityid)
       if (obj.value!="")
        {
            if(obj.value.length<3)
  			    {
  				    alert("Invalid Designation Length")
  				    obj.focus();
				    return false;
  			    }
  			    if(roleid=="")
  			    {
                    if(ROLE_str.indexOf(obj.value)!=-1 )
  			        {
  				        alert("Designation Already Exist")
  				        obj.focus();
				        return false;
  			        }
  			     }
  			     else
  			     {
  			        if(roleid!=obj.value)
  			        {
  			             if(ROLE_str.indexOf(obj.value)!=-1 )
  			                {
  				                alert("Designation Already Exist")
  				                obj.focus();
				                return false;
  			                }
  			        }
  			     }
  	    }
}</script>

    <table cellspacing="1" style="width: 100%">
        <tr style="background-color: white">
            <td align="left">
                <asp:Label ID="lblPageHead" CssClass="blackfnt" Font-Bold="true" runat="server">Role Master</asp:Label>
                <hr align="center" size="1" color="#8ba0e5">
            </td>
        </tr>
    </table>
    <br />
    <asp:UpdateProgress ID="UpdateProgress1" runat="server">
        <ProgressTemplate>
            <asp:Table ID="Table1" runat="server">
                <asp:TableRow>
                    <asp:TableCell>
                        <asp:Image ID="imgwaiting" runat="server" ImageUrl="~/GUI/images/loading.gif" /></asp:TableCell>
                    <asp:TableCell CssClass="blackfnt" Font-Bold="true">&nbsp; Please Wait</asp:TableCell>
                </asp:TableRow>
            </asp:Table>
        </ProgressTemplate>
    </asp:UpdateProgress>
    <table cellspacing="1" style="width: 500px">
        <tr>
            <td align="left" width="15%">
                <asp:UpdatePanel ID="UpdatePanel4" runat="server" UpdateMode="Conditional" RenderMode="Inline">
                    <ContentTemplate>
                        <table border="0" cellpadding="1" cellspacing="1" class="boxbg" width="350">
                            <tr style="background-color: White">
                                <td style="text-align: left" class="blackfnt">
                                    &nbsp;Enter No. of Rows
                                </td>
                                <td style="text-align: left" class="blackfnt">
                                    &nbsp;<asp:TextBox ID="txtRows" runat="server" BorderStyle="Groove" onkeypress="javascript:validInt(event);"
                                        CssClass="input" Width="100px"></asp:TextBox>
                                    <asp:UpdatePanel ID="upAddRow" runat="server" UpdateMode="Conditional" RenderMode="Inline">
                                        <ContentTemplate>
                                            &nbsp;<asp:Button ID="btnAdd" UseSubmitBehavior="false" runat="server" Text="Submit"
                                                OnClick="btnAdd_Click" />
                                        </ContentTemplate>
                                    </asp:UpdatePanel>
                                </td>
                            </tr>
                        </table>
                        <br />
                        <table border="0" cellpadding="0" cellspacing="0" width="500">
                            <tr style="background-color: White">
                                <td style="text-align: left" class="blackfnt">
                                    <asp:UpdatePanel ID="UpdatePanel1" UpdateMode="Conditional" RenderMode="Inline" runat="server">
                                        <ContentTemplate>
                                            <asp:GridView ID="grvcontrols" runat="server" AutoGenerateColumns="False" BorderWidth="0px"
                                                CellSpacing="1" CssClass="boxbg" EmptyDataText="No Records Found..." PagerStyle-HorizontalAlign="left"
                                                Width="100%" ShowFooter="True" OnRowDataBound="grvcontrols_RowDataBound">
                                                <Columns>
                                                    <asp:TemplateField HeaderText="Sr. No.">
                                                        <ItemStyle BackColor="White" CssClass="blackfnt" HorizontalAlign="Center" />
                                                        <HeaderStyle BackColor="#D4E0E7" CssClass="blackfnt" HorizontalAlign="Center" Wrap="False" />
                                                        <ItemTemplate>
                                                            <asp:Label ID="lblsrno" runat="server" Text="<%# Container.DataItemIndex+1 %>"></asp:Label>
                                                            <asp:CheckBox ID="ChkId1" runat="server" />
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="Designation">
                                                        <ItemStyle BackColor="White" CssClass="blackfnt" HorizontalAlign="Center" />
                                                        <HeaderStyle BackColor="#D4E0E7" CssClass="blackfnt" HorizontalAlign="Center" Wrap="False" />
                                                        <ItemTemplate>
                                                            <asp:TextBox ID="txtDesignation" runat="server" BorderStyle="Groove" CssClass="input"
                                                                Enabled="true" Width="150px" onchange="javascript:this.value=this.value.toUpperCase()"
                                                                onblur="javascript:Rolecheck(this)"></asp:TextBox>
                                                            <div id="Dic_Desc" runat="server" class="boxbg" />
                                                            <%--<atlas:AutoCompleteExtender  runat="server" ID="DESI" DropDownPanelID="Dic_Desc">
                                                                <atlas:AutoCompleteProperties  TargetControlID="txtDesignation" ServicePath="AtlasAutoComplete.asmx"
                                                                    ServiceMethod="GetROLEDesc" MinimumPrefixLength="1" Enabled="true" />
                                                            </atlas:AutoCompleteExtender>--%>
                                                            <ajaxToolkit:AutoCompleteExtender ID="DESI" runat="server" Enabled="True" CompletionListItemCssClass="autocomplete_listItem"
                                                                CompletionListHighlightedItemCssClass="autocomplete_highlightedListItem" MinimumPrefixLength="1"
                                                                ServiceMethod="GetROLEDesc" ServicePath="../AtlasAutoComplete.asmx" TargetControlID="txtDesignation">
                                                            </ajaxToolkit:AutoCompleteExtender>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="Hierarchy">
                                                        <ItemStyle BackColor="White" CssClass="blackfnt" HorizontalAlign="Center" />
                                                        <HeaderStyle BackColor="#D4E0E7" CssClass="blackfnt" HorizontalAlign="Center" Wrap="False" />
                                                        <ItemTemplate>
                                                            &nbsp;<asp:DropDownList ID="DLHY" runat="server">
                                                            </asp:DropDownList>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="Multiple Employees For Role">
                                                        <ItemStyle BackColor="White" CssClass="blackfnt" HorizontalAlign="Center" />
                                                        <HeaderStyle BackColor="#D4E0E7" CssClass="blackfnt" HorizontalAlign="Center" Wrap="False" />
                                                        <ItemTemplate>
                                                            &nbsp;
                                                            <asp:CheckBox ID="ChkMul" runat="server" />
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="Active">
                                                        <ItemStyle BackColor="White" CssClass="blackfnt" HorizontalAlign="Center" />
                                                        <HeaderStyle BackColor="#D4E0E7" CssClass="blackfnt" HorizontalAlign="Center" Wrap="False" />
                                                        <ItemTemplate>
                                                            &nbsp;
                                                            <asp:CheckBox ID="ChkActive" runat="server" />
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                </Columns>
                                                <PagerStyle HorizontalAlign="Left" />
                                            </asp:GridView>
                                        </ContentTemplate>
                                        <Triggers>
                                            <asp:AsyncPostBackTrigger ControlID="btnAdd" EventName="Click" />
                                        </Triggers>
                                    </asp:UpdatePanel>
                                    <br />
                                </td>
                            </tr>
                            <tr id="tr1" runat="server" style="background-color: White; display: block;">
                                <td align="center">
                                    <asp:Button ID="btnSubmit" OnClick="btnSubmit_Click" runat="server" BorderStyle="Solid"
                                        BorderWidth="1px" Text="Submit" Width="150px" />
                                </td>
                            </tr>
                        </table>
                    </ContentTemplate>
                </asp:UpdatePanel>
            </td>
        </tr>
    </table>
</asp:Content>
