<%@ Page Language="C#" AutoEventWireup="true"  MasterPageFile="~/GUI/MasterPage.master"  CodeFile="IssueTyre.aspx.cs" Inherits="TYRE1_IssueTyre" %>

   <asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server" >
   <table cellspacing="1" style="width: 100%">
        <tr style="background-color: white">
            <td align="left">
                <asp:Label ID="lblPageHead" runat="server" CssClass="blackfnt" Font-Bold="True">Issue Tyre</asp:Label>
                <hr align="center" color="#8ba0e5" size="1" />
            </td>
        </tr>
    </table>
       
                                         
              <table cellspacing="1"  class="boxbg"  width="40%">
                       <tr class="bgbluegrey">
                        <td colspan="4" align="center">
                            <asp:Label ID="Label1" CssClass="blackfnt" Font-Bold="true" runat="server">Select Issue Type</asp:Label>
                        </td>
                    </tr>
                           
                    <tr style="background-color: white" align="center">
                        <td align="left" style="height: 22px" >
                       <asp:RadioButton ID="rd1" Text="Mount Tyre"  runat="server" CssClass="blackfnt" GroupName="A"/>
                        </td>
                        <td  align="left" style="height: 22px" >
                         <asp:RadioButton ID="rd2"  Text="Service Tyre" runat="server" CssClass="blackfnt" GroupName="A"/></td>
                    </tr>
                  <tr align="center" style="background-color: white">
                      <td align="left" colspan="2" style="vertical-align: middle; text-align: center">
                          <asp:Button ID="btnSubmit" runat="server" OnClick="btnSubmit_Click" Text="Submit" /></td>
                  </tr>
            </table>

                                  
            

 
 
  </asp:Content>
