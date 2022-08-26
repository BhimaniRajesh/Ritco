<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true"
    CodeFile="SundrySlabSelection.aspx.cs" Inherits="SundrySlabSelection" EnableEventValidation="false" %>

<%@ Register Src="~/GUI/admin/CustomerContractMaster/CustContractInfo.ascx" TagName="CustInfo" TagPrefix="cust" %>

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

    <asp:Panel runat="server" Width="10in">
        <asp:Table runat="server" Width="100%">
            <asp:TableRow>
                <asp:TableCell HorizontalAlign="Left">
                   <cust:CustInfo runat="server" ID="cstheader" />
                </asp:TableCell>
            </asp:TableRow>
            <asp:TableRow>
                <asp:TableCell HorizontalAlign="Center">
                <br />
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
         <asp:UpdateProgress ID="uppMain" runat="server">
                <ProgressTemplate>
                    <table style="border: solid #8ba0e5 2px; z-index: 98; position: fixed; width: 200px; -left: -60px; top: 50%;
                            left: 40%;" width="190px" cellpadding="0"
                        bgcolor="white">
                        <tr>
                            <td align="right">
                                <img src="../../images/loading.gif" alt="" />
                            </td>
                            <td>
                                <font face="verdana" color="#0000ff" size="2">&nbsp;&nbsp;&nbsp;<b>Please Wait ...</b></font>
                            </td>
                        </tr>
                    </table>
                    <asp:Panel ID="Panel1" Style="position: fixed; z-index: 97; top: 0px; left: 0px; background-color: #FFFFFF;
                        width: 100%; height: 100%; filter: Alpha(Opacity=50); opacity: .50; -moz-opacity: .50;"
                        runat="server">
                        <asp:Panel Style="z-index: 98; position: fixed; width: 120px; -left: -60px; top: 50%;
                            left: 50%;" ID="Panel2" runat="server">
                        </asp:Panel>
                    </asp:Panel>
                </ProgressTemplate>
            </asp:UpdateProgress>
    </asp:Panel>
   
</asp:Content>
