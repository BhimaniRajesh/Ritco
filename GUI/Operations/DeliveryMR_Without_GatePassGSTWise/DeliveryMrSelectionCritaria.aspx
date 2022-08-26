<%@ Page Title="" Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true" 
CodeFile="DeliveryMrSelectionCritaria.aspx.cs" Inherits="GUI_Operations_DeliveryMR_Without_GatePass_DeliveryMrSelectionCritaria" %>

<%@ Register Src="~/GUI/Common_UserControls/ProgressBar.ascx" TagName="ProgressBar"
    TagPrefix="pgb" %>
<%@ Register Src="~/GUI/Common_UserControls/WebxComplete/XAC.ascx" TagPrefix="xac"
    TagName="WebxComplete" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" Runat="Server">
    <script src="../../images/commonJs.js" type="text/javascript" language="javascript"></script>
    <script src="../../images/CalendarPopup.js" type="text/javascript" language="javascript"></script>
    
    <script type="text/javascript" language="javascript">
        function step1Click() {
            var txtdockno = document.getElementById("ctl00_MyCPH1_txtdockno");
            if (txtdockno.value == "") {
                alert("Please Enter Docket Number...");
                return false;
            }

            return true;
        }
        function step2Click() {
            var TxtMrLocation = document.getElementById("ctl00_MyCPH1_TxtMrLocation");
            var TxtGatePassLocation = document.getElementById("ctl00_MyCPH1_TxtGatePassLocation");
            if (TxtMrLocation.value == "") 
            {
                alert("Please Enter MR Location...");
                return false;
            }
            if (TxtGatePassLocation.value == "") {
                alert("Please Enter Gate Pass Location...");
                return false;
            }
            return true;
        }
        function step3Click() 
        {
            var RadGatePass = document.getElementById("ctl00_MyCPH1_RadGatePass");
            var RadDeliveryMr = document.getElementById("ctl00_MyCPH1_RadDeliveryMr");
            var RadBoth = document.getElementById("ctl00_MyCPH1_RadBoth");
            var TxtMrLocation = document.getElementById("ctl00_MyCPH1_TxtMrLocation");
            var TxtGatePassLocation = document.getElementById("ctl00_MyCPH1_TxtGatePassLocation");
            
            if (TxtMrLocation.value == "") {
                alert("Please Enter MR Location...");
                return false;
            }
            if (TxtGatePassLocation.value == "") {
                alert("Please Enter Gate Pass Location...");
                return false;
            }
            var Falg = "N";
            if (RadGatePass.checked)
                Falg = "Y";
            else if (RadDeliveryMr.checked)
                Falg = "Y";
            else if (RadBoth.checked)
                Falg = "Y";
            if (Falg == "N") 
            {
                alert("Please Select Either Delivery Mr/Gate Pass/Both option");
                return false;
            }            
            return true;
        }
        
        
    </script>
    <asp:UpdatePanel ID="updone" runat="server">
        <ContentTemplate>
            <asp:Panel ID="divmain" runat="server" Width="10in">
                <asp:Table ID="tblmain" runat="server" Width="100%" CellSpacing="1">
                    <asp:TableRow>
                        <asp:TableCell ColumnSpan="4" HorizontalAlign="Center" Font-Bold="true">
                        <asp:Table ID="Table1" runat="server" CellSpacing="1" CssClass="boxbg" Width="100%">
                                <asp:TableRow CssClass="bgbluegrey">
                                    <asp:TableCell Font-Bold="true">
                                    Delivery MR With Seperate Gate Pass Module
                                    </asp:TableCell>
                                </asp:TableRow>
                        </asp:Table>
                        </asp:TableCell>
                    </asp:TableRow>
                    <asp:TableRow ID="trstep1" runat="server" CssClass="bgwhite">
                        <asp:TableCell ColumnSpan="4">
                            <asp:Table ID="Table2" runat="server" Width="100%" CssClass="boxbg" CellSpacing="1">
                                <asp:TableRow ID="trdockno" runat="server" CssClass="bgwhite">
                                    <asp:TableCell Width="25%">
                                        Docket Number
                                    </asp:TableCell>
                                    <asp:TableCell ColumnSpan="3" HorizontalAlign="Left">
                                        <table>
                                            <tr>
                                                <td>
                                                    <asp:TextBox ID="txtdockno" runat="server" Width="100px" MaxLength="15" CssClass="blackfnt"
                                                        BorderStyle="Groove"></asp:TextBox>
                                                </td>
                                                <td>
                                                    <asp:DropDownList ID="ddlsuffix" runat="server" onchange="javascript:return dockNoTest()"
                                                        CssClass="blackfnt" BackColor="White">
                                                        <asp:ListItem Value=".">Original</asp:ListItem>
                                                        <asp:ListItem Value="A">A</asp:ListItem>
                                                        <asp:ListItem Value="B">B</asp:ListItem>
                                                        <asp:ListItem Value="C">C</asp:ListItem>
                                                        <asp:ListItem Value="D">D</asp:ListItem>
                                                        <asp:ListItem Value="E">E</asp:ListItem>
                                                        <asp:ListItem Value="F">F</asp:ListItem>
                                                        <asp:ListItem Value="G">G</asp:ListItem>
                                                        <asp:ListItem Value="H">H</asp:ListItem>
                                                        <asp:ListItem Value="I">I</asp:ListItem>
                                                        <asp:ListItem Value="M">Misroute</asp:ListItem>
                                                        <asp:ListItem Value="X">X</asp:ListItem>
                                                        <asp:ListItem Value="Y">Y</asp:ListItem>
                                                        <asp:ListItem Value="Z">Z</asp:ListItem>
                                                    </asp:DropDownList>
                                                </td>
                                                <td>
                                                    <asp:Image ID="imgdockettick" runat="server" Style="display: none;" Width="15px"
                                                        Height="15px" ImageUrl="~/GUI/images/dockettick.jpg" />
                                                </td>
                                            </tr>
                                            <tr>
                                                <td colspan="3">
                                                    <asp:Label ID="lblmessage" Font-Bold="true" runat="server" CssClass="redfnt"></asp:Label>
                                                </td>
                                            </tr>
                                        </table>
                                    </asp:TableCell>
                                </asp:TableRow>
                                <asp:TableRow ID="TableRow1" runat="server" CssClass="bgbluegrey">
                                    <asp:TableCell ColumnSpan="4" HorizontalAlign="Right">
                                        <asp:Button ID="btnstep1" Text="Step 1" OnClientClick="javascript:return step1Click()"
                                            OnClick="btnstep1_Click" runat="server" CssClass="blackfnt" />
                                    </asp:TableCell>
                                </asp:TableRow>
                            </asp:Table>
                        </asp:TableCell>
                    </asp:TableRow>
                    <asp:TableRow CssClass="bgwhite" ID="trstep2" runat="server">
                        <asp:TableCell ColumnSpan="4">
                            <asp:Table ID="Table3" runat="server" Width="100%" CssClass="boxbg" CellSpacing="1">
                                <asp:TableRow ID="TableRow2" runat="server" CssClass="bgwhite">
                                    <asp:TableCell Width="20%">
                                        Delivery MR generated
                                    </asp:TableCell>
                                    <asp:TableCell HorizontalAlign="Left" Width="20%">
                                        <asp:Label ID="LblMrStatus" runat="server" CssClass="blackfnt"></asp:Label>
                                    </asp:TableCell>
                                    <asp:TableCell Width="20%">
                                        Delivery MR location
                                    </asp:TableCell>
                                    <asp:TableCell HorizontalAlign="Left" Width="40%">
                                        <asp:TextBox ID="TxtMrLocation" runat="server" CssClass="blackfnt"></asp:TextBox>
                                        <xac:WebxComplete ID="xacMrLoc" runat="server" MinPrefixLength="2" WebxEntity="BranchCode"
                                            CodeTarget="TxtMrLocation" FilterString="1,2,3" />
                                    </asp:TableCell>
                                </asp:TableRow>
                                <asp:TableRow ID="TableRow3" runat="server" CssClass="bgwhite">
                                    <asp:TableCell>
                                        Gate Pass Generated
                                    </asp:TableCell>
                                    <asp:TableCell HorizontalAlign="Left">
                                        <asp:Label ID="LblGatePassStatus" runat="server" CssClass="blackfnt"></asp:Label>
                                    </asp:TableCell>
                                    <asp:TableCell>
                                        Gate Pass Generation Location
                                    </asp:TableCell>
                                    <asp:TableCell HorizontalAlign="Left">
                                        <asp:TextBox ID="TxtGatePassLocation" runat="server" CssClass="blackfnt"></asp:TextBox>
                                        <xac:WebxComplete ID="xacGatePassLoc" runat="server" MinPrefixLength="2" WebxEntity="BranchCode"
                                            CodeTarget="TxtGatePassLocation" FilterString="1,2,3" />
                                        <asp:HiddenField ID="hdnfinstartyear" runat="server" />     
                                    </asp:TableCell>
                                </asp:TableRow>                 
                           </asp:Table>
                        </asp:TableCell>   
                    </asp:TableRow>
                    <asp:TableRow CssClass="bgwhite" ID="trstep3" runat="server">
                        <asp:TableCell ColumnSpan="4">
                            <asp:Table ID="Table4" runat="server" Width="100%" CssClass="boxbg" CellSpacing="1">
                                <asp:TableRow ID="TableRow6" runat="server" CssClass="bgwhite">
                                    <asp:TableCell Width="20%">
                                        Generate
                                    </asp:TableCell>
                                    <asp:TableCell HorizontalAlign="Left" Width="20%">
                                        <asp:RadioButton ID="RadGatePass" runat="server" Text="Gate Pass" GroupName="MrGroup"/>
                                    </asp:TableCell>
                                    <asp:TableCell Width="20%">
                                        <asp:RadioButton ID="RadDeliveryMr" runat="server" Text="Delivery MR" GroupName="MrGroup"/>
                                    </asp:TableCell>
                                    <asp:TableCell HorizontalAlign="Left" Width="40%">
                                        <asp:RadioButton ID="RadBoth" runat="server" Text="Both" GroupName="MrGroup" />
                                    </asp:TableCell>
                                </asp:TableRow>
                                <asp:TableRow ID="TableRow4" runat="server" CssClass="bgwhite">
                                    <asp:TableCell ColumnSpan="4">
                                        <asp:Label ID="lblmessage2" Font-Bold="true" runat="server" CssClass="redfnt"></asp:Label>    
                                    </asp:TableCell>
                                </asp:TableRow>
                                <asp:TableRow ID="TableRow5" runat="server" CssClass="bgbluegrey">
                                    <asp:TableCell ColumnSpan="4" HorizontalAlign="Right">
                                        <asp:Button ID="btnstep3" Text="Submit" OnClientClick="javascript:return step3Click()"
                                            OnClick="btnstep3_Click" runat="server" CssClass="blackfnt" />
                                    </asp:TableCell>
                                </asp:TableRow>
                             </asp:Table>   
                        </asp:TableCell>
                    </asp:TableRow>    
                </asp:Table>
            </asp:Panel>
        </ContentTemplate>
    </asp:UpdatePanel>    
</asp:Content>

