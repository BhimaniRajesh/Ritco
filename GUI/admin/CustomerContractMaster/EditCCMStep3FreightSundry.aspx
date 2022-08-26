<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true"
    CodeFile="EditCCMStep3FreightSundry.aspx.cs" Inherits="EditCCMStep3FreightSundry"
    EnableEventValidation="false" %>

<%@ OutputCache Location="none" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">

    <script language="javascript" type="text/javascript">

            function SingleSlabSelect()
            {
                if(document.getElementById("ctl00_MyCPH1_radMultiple"))
                {
                    document.getElementById("ctl00_MyCPH1_radMultiple").checked = false;
                }
            }

            function MultiSlabSelect()
            {
                if(document.getElementById("ctl00_MyCPH1_radSingle"))
                {
                    document.getElementById("ctl00_MyCPH1_radSingle").checked = false;
                }
            }
            
            function ValidateData()
            {
                //Check for Any one of radio buttons
                if(document.getElementById("ctl00_MyCPH1_radSingle") && document.getElementById("ctl00_MyCPH1_radMultiple"))
                {
                    if(document.getElementById("ctl00_MyCPH1_radSingle").checked == false && document.getElementById("ctl00_MyCPH1_radMultiple").checked == false)
                    {
                        alert("Please select either 'Single Slab Contract' or 'Multi Slab Detailed Contract' to proceed");
                        document.getElementById("ctl00_MyCPH1_radSingle").focus();
                        return false;
                    }
                }
                
                return true;
            }
            
    </script>

   <br />
    <asp:Table ID="Table1" HorizontalAlign="Left" runat="server" CssClass="blackfnt" >
             <asp:TableRow BackColor="White">
                <asp:TableCell>
				       &nbsp;ContractID  
                </asp:TableCell>
                <asp:TableCell>
                     : <asp:Label ID="lblcontractid" runat="server" onmouseover="this.style.cursor='pointer'" CssClass="redfnt" Font-Bold="true"></asp:Label>
                </asp:TableCell>
            </asp:TableRow>
                         <asp:TableRow BackColor="White">
                <asp:TableCell>
				       &nbsp;Customer Code & Name &nbsp;
                </asp:TableCell>
                <asp:TableCell>
                : <asp:Label ID="lblcustcodename" runat="server" onmouseover="this.style.cursor='pointer'" CssClass="blackfnt" Font-Bold="true"></asp:Label>
                </asp:TableCell>
            </asp:TableRow>
        </asp:Table> 
        <br /><br /><br />
    <div style="width: 10in;" align="center">
        <br />
        
        <table width="80%" border="0" cellspacing="0" cellpadding="0">
            <tr>
                <td style="width: 39%" valign="top">
                    <table border="0" cellpadding="2" width="85%" cellspacing="1" align="center" class="boxbg">
                        <tr class="bgbluegrey">
                            <td colspan="3">
                                <b>Single/Multiple Slab Selection</b>
                            </td>
                        </tr>
                        <tr style="background-color: White">
                            <td align="left">
                                <input type="radio" id="radSingle" value="S" runat="server" onclick="SingleSlabSelect()" />
                            </td>
                            <td align="left">
                                Single Slab Contract
                            </td>
                            <td align="left">
                                3A</td>
                        </tr>
                        <tr style="background-color: White">
                            <td align="left">
                                <input type="radio" id="radMultiple" value="M" runat="server" onclick="MultiSlabSelect()" />
                            </td>
                            <td align="left">
                                Multi Slab Detailed Contract
                            </td>
                            <td align="left">
                                3B
                            </td>
                        </tr>
                        <tr class="bgbluegrey">
                            <td colspan="3">
                                <asp:Button ID="btnSubmit" Text="Submit" runat="server" ToolTip="Click here to submit and proceed"
                                    CssClass="blackfnt" OnClientClick="return ValidateData()" OnClick="btnSubmit_Click" />
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
    </div>
</asp:Content>
