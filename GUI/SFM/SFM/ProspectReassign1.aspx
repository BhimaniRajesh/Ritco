<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true" CodeFile="ProspectReassign1.aspx.cs" Inherits="SFM_ProspectReassign1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" Runat="Server">

<script type="text/javascript" language="javascript" src="../CAL/datetimepicker.js"></script>
    <link href="../CAL/popcalendar.css" type="text/css" rel="stylesheet" />
    <script language="javascript" type="text/javascript" src="../CAL/popcalendar.js"></script>
    
    <script language="javascript" type="text/javascript">
    
    function(txtReassignProspect,txtReassignProspect)
    {
        if(txtReassignProspect.value="")
        {
        alert('Please Enter Sales Manager Name')
        txtReassignProspect
        return false
        }
        if(txtReassignProspect.value="")
        {
        alert('Please Enter Sales Manager Name')
        return false
        }
    }
    
    
    </script>
    
<div align="center">

<table style="width: 100%">

        <tr>
            <td align="left"  colspan="3">
                <asp:Label ID="lblWelcome" runat="server" Text="Prospect Reassign" CssClass="blackfnt" Font-Bold="true"></asp:Label>
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
                            <tr class="bgbluegrey">
                                                        <td align="center" colspan="5" style="height: 25px">
                                                            <font class="blackfnt"><strong>Reassign Prospect</strong></font></td>
                                                    </tr>
                            
                
                
                <tr bgcolor="white">
                    <td align="left" class="field1">
                         <font class="blackfnt">Prospect/Customer Id.</font>
                    </td>
                    <td align="left"  colspan="2">
                    <font class="blackfnt">
                    <asp:Label ID="lblProspectCode" runat="server"></asp:Label>
                    </font>
                    
                       
                    </td>
                    <td align="left" class="field1" >
                         <font class="blackfnt">Sales Person</font>
                    </td>
                    <td align="left" >
                  <font class="blackfnt">
                    <asp:Label ID="lblSalesPerson" runat="server"></asp:Label>
                    </font>
                    </td>
                </tr>
                <tr bgcolor="white">
                    <td align="left" class="field1" >
                         <font class="blackfnt">Reassign Prospect To</font>
                    </td>
                    <td align="left" colspan="2" >
                     <asp:TextBox ID="txtReassignProspect" runat="server" Width="88px"></asp:TextBox>  
                       <input id="btnCust" type="button" name="" runat="server"/>
                    </td>
                    <td align="left" class="field1">
                         <font class="blackfnt">Reassign date</font>
                    </td>
                    <td align="left">
                        
                        <asp:TextBox ID="txtReassignDate" runat="server" Width="81"></asp:TextBox>
                        
                    </td>
                </tr>
</table>
<br />
<br />
        <table align="center" cellspacing="1" cellpadding="1" width="85%" border="0">
        <tr bgcolor="white" align="center">
                    
                    <td style="width: 138px; height: 22px;" colspan="6">
                         <asp:Button ID="btnSubmit" runat="server" Height="24px" Text="Submit" Width="80px" style="left: 342px; position: relative; top: -1px" OnClick="btnSubmit_Click" />
                    </td>
                </tr>
        </table>
        <asp:HiddenField ID="hidempcdold" runat="server" />
</div>
</asp:Content>
