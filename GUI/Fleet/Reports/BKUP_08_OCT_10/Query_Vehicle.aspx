<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master"   AutoEventWireup="true" CodeFile="Query_Vehicle.aspx.cs" Inherits="GUI_MIS_Vehicle_Register_Query_Vehicle" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" Runat="Server">




   <br />
    <br />
    <table align="Left" border="0" cellpadding="1" cellspacing="1" class="boxbg" style="width: 50%; ">
       <tr class="bgbluegrey">
            <td align="center" colspan="2" class="blackfnt">
               Vehicle Register Report </td>
        </tr>
        <tr style="background-color: white">
            <td class="blackfnt">                &nbsp;Select Location</td>
            <td class="blackfnt" >
                &nbsp;<asp:DropDownList ID="DDlocation" runat="server">
                    
                </asp:DropDownList>&nbsp;</td>
        </tr>
         <tr style="background-color: white">
            <td class="blackfnt">                &nbsp;Select Vehicle</td>
            <td class="blackfnt" >
                &nbsp;<asp:DropDownList ID="DDVehicle" runat="server">
                    
                </asp:DropDownList>&nbsp;</td>
        </tr>
        
         <tr align="center" style="background-color: white">
            <td class="blackfnt" colspan="2">OR</td>
           
        </tr>
        
        <tr style="background-color: white">
            <td class="blackfnt">                &nbsp;Enter  Vehicle No.</td>
            <td class="blackfnt" >&nbsp;<asp:TextBox ID="txtVehno"  runat="server" Width="272px"></asp:TextBox>
                </td>
        </tr>
        
        
        
        
         <tr style="background-color: white">
            <td align="center" colspan="2">
             
                    <asp:UpdatePanel ID="UpdatePanel2" runat="server">
                                                    <ContentTemplate>   
                                                    <asp:Button ID="btnSubmit" runat="server" Text="Submit"  OnClick="btnSubmit_Click"/>
                   </ContentTemplate>
                                                  
                                                </asp:UpdatePanel></td>
        </tr>
    </table>
















</asp:Content>