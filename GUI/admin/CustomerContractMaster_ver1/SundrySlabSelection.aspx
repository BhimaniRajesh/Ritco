<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true"
    CodeFile="SundrySlabSelection.aspx.cs" Inherits="SundrySlabSelection" EnableEventValidation="false" %>

<%@ OutputCache Location="none" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">

    <script language="javascript" type="text/javascript">

            function btnsubmitClick()
            {
                var optsingle = document.getElementById("ctl00_MyCPH1_optsingle");
                var optmultiple = document.getElementById("ctl00_MyCPH1_optmultiple");
                var optrange = document.getElementById("ctl00_MyCPH1_optrange");
                
                if(optsingle.checked==false && optmultiple.checked==false && optrange.checked==false)
                {
                    alert("No option is Selected. Please select any one Option");
                    return false;
                }
                
                return true;
            }
            
    </script>

    <br />
    <br />
    <asp:Panel runat="server" Width="10in">
        <asp:Table runat="server" Width="100%">
            <asp:TableRow>
                <asp:TableCell>
                    <asp:Table ID="Table1" HorizontalAlign="Left" runat="server" CssClass="blackfnt">
                        <asp:TableRow BackColor="White">
                            <asp:TableCell>
				       &nbsp;ContractID  
                            </asp:TableCell>
                            <asp:TableCell>
                                :
                                <asp:Label ID="lblcontractid" runat="server" onmouseover="this.style.cursor='pointer'"
                                    CssClass="redfnt" Font-Bold="true"></asp:Label>
                            </asp:TableCell>
                        </asp:TableRow>
                        <asp:TableRow BackColor="White">
                            <asp:TableCell>
				       &nbsp;Customer Code & Name &nbsp;
                            </asp:TableCell>
                            <asp:TableCell>
                                :
                                <asp:Label ID="lblcustcodename" runat="server" onmouseover="this.style.cursor='pointer'"
                                    CssClass="blackfnt" Font-Bold="true"></asp:Label>
                            </asp:TableCell>
                        </asp:TableRow>
                    </asp:Table>
                </asp:TableCell>
            </asp:TableRow>
            <asp:TableRow>
                <asp:TableCell HorizontalAlign="Center">
                <br /><br />
                    <asp:Table CellSpacing="1" Width="60%" CellPadding="0" runat="server" CssClass="boxbg">
                        <asp:TableRow CssClass="bgbluegrey">
                            <asp:TableCell ColumnSpan="2" Font-Bold="true">
                            Single/Multiple Slab Selection
                            </asp:TableCell>
                        </asp:TableRow>
                        <asp:TableRow CssClass="bgwhite">
                            <asp:TableCell HorizontalAlign="Center">
                                <asp:RadioButton ID="optsingle" runat="server" GroupName="grpsundry" />
                            </asp:TableCell>
                            <asp:TableCell HorizontalAlign="left">
                            Single Slab Contract
                            </asp:TableCell>
                        </asp:TableRow>
                        <asp:TableRow CssClass="bgwhite">
                            <asp:TableCell HorizontalAlign="Center">
                                <asp:RadioButton ID="optmultiple" runat="server" GroupName="grpsundry" />
                            </asp:TableCell>
                            <asp:TableCell HorizontalAlign="left">
                            Multi Slab Contract
                            </asp:TableCell>
                        </asp:TableRow>
                        <asp:TableRow CssClass="bgwhite">
                            <asp:TableCell HorizontalAlign="Center">
                                <asp:RadioButton ID="optrange" runat="server" GroupName="grpsundry" />
                            </asp:TableCell>
                            <asp:TableCell HorizontalAlign="left">
                            Multiple Slab Range
                            </asp:TableCell>
                        </asp:TableRow>
                        <asp:TableRow CssClass="bgbluegrey">
                            <asp:TableCell ColumnSpan="2">
                                <asp:Button ID="btnsubmit" Text="Submit" runat="server" CssClass="blackfnt" OnClientClick="javascript:return btnsubmitClick()"
                                    OnClick="btnsubmit_Click" />
                            </asp:TableCell>
                        </asp:TableRow>
                    </asp:Table>
                </asp:TableCell>
            </asp:TableRow>
        </asp:Table>
    </asp:Panel>
    <br />
    <br />
    <br />
    <br />
    <br />
</asp:Content>
