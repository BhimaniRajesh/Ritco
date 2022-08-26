<%@ Page  Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true"
    CodeFile="Manage_DCR.aspx.cs" Inherits="GUI_admin_DCR_Manage_DCR" %>

<%@ Register Src="../../Common_UserControls/MyMessageBox.ascx" TagName="MyMessageBox"
    TagPrefix="uc1" %>
<%@ Register Src="../../Common_UserControls/ProgressBar.ascx" TagName="ProgressBar"
    TagPrefix="uc2" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">
    
    <script type="text/javascript" language="javascript">
        function MakeUpper(objRef) {
            // This gets the value for the textbox that was focussed
            var curValue = objRef.value;
            //Assign the suggested value to the box
            objRef.value = curValue.toUpperCase();
        }
    </script>

    <div class="blackfnt">
        <table cellspacing="1" style="width: 100%">
            <tr style="background-color: white">
                <td align="left">
                    <asp:Label ID="lblPageHead" CssClass="blackfnt" Font-Bold="true" runat="server">Manage Series</asp:Label>
                    <hr align="center" size="1" color="#8ba0e5" />
                </td>
            </tr>
        </table>
        <br />
        <uc2:ProgressBar ID="ProgressBar1" runat="server" />
        <asp:UpdatePanel ID="UpdatePanel2" runat="server" UpdateMode="Conditional" RenderMode="Inline">
            <ContentTemplate>
        <div id="dvFilter" runat="server">
            <table cellspacing="1" cellpadding="2" class="boxbg" border="0" width="500">
                <tr class="bgbluegrey">
                    <td colspan="2" align="center">
                        <b>Select Series to be managed</b>
                    </td>
                </tr>
                <tr class="bgwhite">
                    <td width="150">
                        Select Document Type:
                    </td>
                    <td>
                        <asp:DropDownList ID="ddlDocType" runat="server" CssClass="blackfnt">
                        </asp:DropDownList>
                    </td>
                </tr>
                <tr class="bgwhite">
                    <td>
                        Document Number:
                    </td>
                    <td>
                        <asp:TextBox ID="txtDocNo" runat="server" MaxLength="50" Width="200"></asp:TextBox>
                        <ajaxToolkit:TextBoxWatermarkExtender ID="TextBoxWatermarkExtender1" runat="server" TargetControlID="txtDocNo"
                            WatermarkCssClass="Watermark" WatermarkText="Please enter document number here..." />
                    </td>
                </tr>
                <tr class="bgbluegrey">
                    <td colspan="2" align="center">
                        <asp:Button ID="btnSubmit" runat="server" Text="Submit" BorderStyle="Groove" Width="85"
                            OnClick="btnSubmit_Click" />
                    </td>
                </tr>
            </table>
            <br />
        </div>
         </ContentTemplate>
            <Triggers>
                <asp:AsyncPostBackTrigger ControlID="btnDoAction" EventName="Click" />
                <asp:AsyncPostBackTrigger ControlID="btnReAllocate" EventName="Click" />
            </Triggers>
        </asp:UpdatePanel>
        <asp:UpdatePanel ID="updtDetail" runat="server" UpdateMode="Conditional" RenderMode="Inline">
            <ContentTemplate>
                <div id="dvDetails" runat="server">
                    <table cellspacing="1" cellpadding="2" class="boxbg" border="0" width="500">
                        <tr class="bgbluegrey">
                            <td colspan="2" align="left">
                                <b>You have selected following series to manage:</b>
                            </td>
                        </tr>
                        <tr class="bgwhite">
                            <td style="width:100px">
                                Document type:
                            </td>
                            <td>
                                <asp:Label ID="lblDocType" runat="server"></asp:Label>
                            </td>
                        </tr>
                        <tr class="bgwhite">
                            <td>
                                Query number:
                            </td>
                            <td>
                                <asp:Label ID="lblQNo" runat="server"></asp:Label>
                            </td>
                        </tr>
                        <tr class="bgwhite">
                            <td>
                                Book number:
                            </td>
                            <td>
                                <asp:Label ID="lblBookCode" runat="server"></asp:Label>
                                <asp:HiddenField ID="hidDocKey" runat="server" />
                            </td>
                        </tr>
                        <tr class="bgwhite" >
                            <td>
                                Series start-end:
                            </td>
                            <td nowrap>
                                <asp:Label ID="lblFromTo" runat="server"></asp:Label>
                            </td>
                        </tr>
                        <tr class="bgwhite">
                            <td>
                                Total leaves:
                            </td>
                            <td>
                                <asp:Label ID="lblTotLeaves" runat="server"></asp:Label>
                            </td>
                        </tr>
                        <tr class="bgwhite">
                            <td>
                                Used leaves:
                            </td>
                            <td>
                                <asp:Label ID="lblUsedLeaves" runat="server"></asp:Label>
                            </td>
                        </tr>
                        <tr class="bgwhite">
                            <td>
                                Allocated to location:
                            </td>
                            <td>
                                <asp:Label ID="lblAllotedToLoc" runat="server"></asp:Label>
                            </td>
                        </tr>
                        <tr class="bgwhite">
                            <td>
                                Allocated to person:
                            </td>
                            <td>
                                <asp:Label ID="lblAllotedToPer" runat="server"></asp:Label>
                            </td>
                        </tr>
                        <tr class="bgwhite">
                            <td>
                                Allocated person category:
                            </td>
                            <td>
                                <asp:Label ID="lblAllotedType" runat="server"></asp:Label>
                            </td>
                        </tr>
                        <tr class="bgwhite">
                            <td>
                                Hierarchy of that location:
                            </td>
                            <td>
                                <asp:Label ID="lblLocHierarchy" runat="server"></asp:Label>
                            </td>
                        </tr>
                        <tr class="bgwhite">
                            <td>
                                Status:
                            </td>
                            <td>
                                <asp:Label ID="lblStatus" runat="server"></asp:Label>
                            </td>
                        </tr>
                        <tr class="bgwhite">
                            <td>
                                Select Action:
                            </td>
                            <td>
                                <asp:DropDownList ID="ddlAction" runat="server">
                                    <asp:ListItem Text="--SELECT--" Value=""></asp:ListItem>
                                    <asp:ListItem Text="Split" Value="1"></asp:ListItem>
                                    <asp:ListItem Text="ReAllocate" Value="3"></asp:ListItem>
                                </asp:DropDownList>
                            </td>
                        </tr>
                        <tr class="bgbluegrey">
                            <td colspan="2" align="center">
                                <asp:Button ID="btnDoAction" runat="server" Text="Next >>" BorderStyle="Groove" Width="85"
                                    OnClick="btnDoAction_Click" />
                            </td>
                        </tr>
                    </table>
                    <br />
                </div>
            </ContentTemplate>
            <Triggers>
                <asp:AsyncPostBackTrigger ControlID="btnSubmit" EventName="Click" />
            </Triggers>
        </asp:UpdatePanel>
        <asp:UpdatePanel ID="UpdatePanel3" runat="server" UpdateMode="Conditional" RenderMode="Inline">
            <ContentTemplate>
                <div id="dvAllocate" runat="server">
                    <table cellspacing="1" cellpadding="2" class="boxbg" border="0" width="500">
                        <tr class="bgbluegrey">
                            <td colspan="2" align="left">
                                <b>Specify reallocation details:</b>
                            </td>
                        </tr>
                        <tr class="bgwhite">
                            <td style="width:200px">
                                Select new allocation location:
                            </td>
                            <td>
                                <asp:DropDownList ID="ddlNewAllotLoc" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ddlNewAllotLoc_SelectedIndexChanged">
                                    <asp:ListItem Text="--SELECT--" Value="" ></asp:ListItem>        
                                </asp:DropDownList>
                                <ajaxToolkit:ListSearchExtender ID="ListSearchExtender1" runat="server" 
                                    TargetControlID="ddlNewAllotLoc" PromptCssClass="ListSearchExtenderPrompt" IsSorted="true"></ajaxToolkit:ListSearchExtender>
                            </td>
                        </tr>
                        <tr class="bgwhite">
                            <td>
                                Select new allocation category:
                            </td>
                            <td>
                                <asp:DropDownList ID="ddlAllotCat" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ddlAllotCat_SelectedIndexChanged">
                                    <asp:ListItem Text="--SELECT--" Value=""></asp:ListItem>        
                                </asp:DropDownList>
                                <ajaxToolkit:ListSearchExtender ID="ListSearchExtender2" runat="server"
                                 TargetControlID="ddlAllotCat" PromptCssClass="ListSearchExtenderPrompt" IsSorted="true" ></ajaxToolkit:ListSearchExtender>                                
                            </td>
                        </tr>                        
                        <tr class="bgwhite">
                            <td>
                                Select person to be assigned series:
                            </td>
                            <td>
                                <asp:DropDownList ID="ddlAllotPerson" runat="server">
                                    <asp:ListItem Text="--SELECT--" Value=""></asp:ListItem>        
                                </asp:DropDownList>
                                <ajaxToolkit:ListSearchExtender ID="ListSearchExtender3" runat="server"
                                 TargetControlID="ddlAllotPerson" PromptCssClass="ListSearchExtenderPrompt" IsSorted="true" ></ajaxToolkit:ListSearchExtender>
                            </td>
                        </tr>
                        <tr class="bgbluegrey">
                            <td colspan="2" align="center">
                                <asp:Button ID="btnReAllocate" runat="server" Text="Re-Allocate" 
                                    BorderStyle="Groove" Width="100" onclick="btnReAllocate_Click" />
                            </td>
                        </tr>
                    </table>
                    <br />
                </div>
            </ContentTemplate>
            <Triggers>                
                <asp:AsyncPostBackTrigger ControlID="btnDoAction" EventName="Click" />
            </Triggers>
        </asp:UpdatePanel>
        <asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Conditional" RenderMode="Inline">
            <ContentTemplate>
                <table border="0" width="500">
                    <tr>
                        <td>
                            <uc1:MyMessageBox ID="msgBox" runat="server" ShowCloseButton="true" /> 
                        </td>
                    </tr>
                </table>
            </ContentTemplate>
            <Triggers>
                <asp:AsyncPostBackTrigger ControlID="btnSubmit" EventName="Click" />
                <asp:AsyncPostBackTrigger ControlID="btnDoAction" EventName="Click" />
                <asp:AsyncPostBackTrigger ControlID="btnReAllocate" EventName="Click" />
                <asp:AsyncPostBackTrigger ControlID="ddlNewAllotLoc" EventName="SelectedIndexChanged" />
                <asp:AsyncPostBackTrigger ControlID="ddlAllotCat" EventName="SelectedIndexChanged" />
            </Triggers>
        </asp:UpdatePanel>
    </div>
</asp:Content>
