<%@ Page Language="C#" AutoEventWireup="true" CodeFile="popup_TyreSize.aspx.cs"
    Inherits="GUI_popups_vehno" %>

<%--<%@ Register Src="~/GUI/usercontrol/javachild.ascx" TagName="JavaUpdate" TagPrefix="JU" %>
<%@ Reference Control="~/GUI/usercontrol/javachild.ascx"%>
--%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Select Tyre Size</title>
    <link id="Link1" href="~/GUI/images/style.css" rel="Stylesheet" type="text/css" runat="server" />
     <script type="text/javascript" language="javascript">
         function selectTyreSizeName(obj) 
         {
            var returnValue = obj.value.split("~");
            var hf_Opener_VehNo = document.getElementById("hSizeNm").value
            //var hf_Opener_Id = document.getElementById("hSizeId").value
            window.opener.document.getElementById(hf_Opener_VehNo).value=returnValue[0];
            //window.opener.document.getElementById(hf_Opener_Id).innerText=returnValue[1];
            window.close();
        }
    </script>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <asp:ScriptManager ID="ScriptManager1" runat="server">
            </asp:ScriptManager>
          
            <table cellspacing="1" style="width: 100%; font-size: 8pt; font-family: Verdana;"  border="1" cellpadding="0">
     
                <tr style="background-color: white">
                    <td align="left" style="vertical-align: top; width: 40%; text-align: left">
                    <asp:HiddenField ID="hSizeNm" runat="server" Value=""/>
                        <asp:Label ID="Label1" runat="server" Text="Enter Tyre Size:"></asp:Label></td>
                    <td align="left" style="width: 60%">
                        <asp:TextBox ID="txtSizeName" runat="server" Font-Names="Verdana" Font-Size="8pt"></asp:TextBox>
                        
                         <ajaxToolkit:AutoCompleteExtender
                runat="server" 
                BehaviorID="AutoCompleteEx"
                ID="autoComplete1" 
                TargetControlID="txtSizeName"
                ServicePath="../../services/FleetAutoComplet.asmx" 
                ServiceMethod="GetTyreSize"
                MinimumPrefixLength="1" 
                CompletionInterval="1000"
                EnableCaching="true"
                CompletionSetCount="20"
                CompletionListCssClass="autocomplete_completionListElement" 
                CompletionListItemCssClass="autocomplete_listItem" 
                CompletionListHighlightedItemCssClass="autocomplete_highlightedListItem"
                DelimiterCharacters=";, :"
                ShowOnlyCurrentWordInCompletionListItem="true" >
                <Animations>
                    <OnShow>
                        <Sequence>
                            <%-- Make the completion list transparent and then show it --%>
                            <OpacityAction Opacity="0" />
                            <HideAction Visible="true" />
                            
                            <%--Cache the original size of the completion list the first time
                                the animation is played and then set it to zero --%>
                            <ScriptAction Script="
                                // Cache the size and setup the initial size
                                var behavior = $find('AutoCompleteEx');
                                if (!behavior._height) {
                                    var target = behavior.get_completionList();
                                    behavior._height = target.offsetHeight - 2;
                                    target.style.height = '0px';
                                }" />
                            
                            <%-- Expand from 0px to the appropriate size while fading in --%>
                            <Parallel Duration=".4">
                                <FadeIn />
                                <Length PropertyKey="height" StartValue="0" EndValueScript="$find('AutoCompleteEx')._height" />
                            </Parallel>
                        </Sequence>
                    </OnShow>
                    <OnHide>
                        <%-- Collapse down to 0px and fade out --%>
                        <Parallel Duration=".4">
                            <FadeOut />
                            <Length PropertyKey="height" StartValueScript="$find('AutoCompleteEx')._height" EndValue="0" />
                        </Parallel>
                    </OnHide>
                </Animations>
            </ajaxToolkit:AutoCompleteExtender>
                  
                    </td>
                </tr>
                <tr style="background-color: white">
                    <td align="left" style="width: 30%">
                    </td>
                    <td align="left" style="width: 70%; text-align: right">
                        <asp:Button ID="btnSubmit" runat="server" OnClick="btnSubmit_Click" Text="Submit" /></td>
                </tr>
                <tr style="background-color: white">
                    <td align="left" style="height: 56px; width: 100%;" colspan="2">
                        <asp:GridView Width="100%" HeaderStyle-CssClass="dgHeaderStyle" CssClass="dgRowStyle" BorderColor="#8BA0E5"
                            BorderWidth="1px" CellPadding="3" ID="GridView1" runat="server"
                            AutoGenerateColumns="False" DataKeyNames="TYRE_SIZEID" >
                            <Columns>
                                <asp:TemplateField ShowHeader="False">
                                    <ItemTemplate>
                                        <input type="radio" name="radSelect" onclick="javascript:selectTyreSizeName(this);" value='<%#Eval("TYRE_SIZENAME")%>~<%#Eval("TYRE_SIZEID")%>' />
                                    </ItemTemplate>
                                    <ControlStyle Width="20%" />
                                </asp:TemplateField>
                                <asp:BoundField DataField="TYRE_SIZENAME" HeaderText="Tyre Size Name" ReadOnly="True" SortExpression="TYRE_SIZENAME" >
                                    <ControlStyle Width="80%" />
                                </asp:BoundField>
                            </Columns>
                            <HeaderStyle CssClass="dgHeaderStyle" Font-Size="10pt" Font-Bold="False" />
                        </asp:GridView>
                    </td>
                </tr>
            </table>
          
        </div>
    </form>
</body>
</html>
