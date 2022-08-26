<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true" CodeFile="ProspectHistory.aspx.cs" Inherits="REPORT_ProspectHistory" Title="Untitled Page" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" Runat="Server">
<div align="center">
    
    <table style="width: 100%">

        <tr>
            <td align="left"  colspan="3">
                <asp:Label ID="lblWelcome" runat="server" Text="Prospect History" CssClass="blackfnt" Font-Bold="true"></asp:Label>
                <hr align="center" size="1" color="#8ba0e5">
            </td>
        </tr>
        </table>
        <br />

<table align="center" border="0" cellpadding="0" cellspacing="0" width="100%">
                <tr>
                    <td align="right" style="height: 33px">
                        <a href="javascript:window.history.go(-1)" title="back">
                        <img border="0" src="../images/back.gif" /></a>
                    </td>
                </tr>
            </table>
            <br />
            
            <table bgcolor="#808080" border="0" cellpadding="3" cellspacing="1" class="boxbg"
                            cols="1" width="85%">
                            <%--<tr class="bgbluegrey">
                                                        <td align="center" colspan="5">
                                                            <font class="blackfnt"><strong>Please Select Appointment</strong></font></td>
                                                    </tr>--%>
                            
                
                
                <tr bgcolor="white">
                    <td align="left" class="field1" style="width: 136px; height: 21px;">
                         <font class="blackfnt">Prospect/Customer Id.</font>
                    </td>
                    <td align="left" style="width: 138px; height: 21px;">
                    <asp:TextBox ID="txtCustCode" runat="server" Width="60px"></asp:TextBox>                                            
                    <input id="btnCust" type="button" name="" runat="server"/>
                    </td>
                </tr>
                
                
                
          </table>
          <br />
        <table align="center" cellspacing="1" cellpadding="1" width="85%" border="0">
        <tr bgcolor="white" align="center">
                    
                    <td style="width: 138px; height: 22px;" colspan="6">
                         <asp:Button ID="btnSubmit" runat="server" Height="24px" Text="Submit" Width="80px" style="left: 342px; position: relative; top: -1px" OnClick="btnSubmit_Click" />
                    </td>
                </tr>
        </table>
        </div>
</asp:Content>

