<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true"
    CodeFile="STax_Rule.aspx.cs" Inherits="GUI_Octroi_Ver1_Octroi_Bill_STax_Rule" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">

    <script language="javascript" type="text/javascript">
        function validFloat(event,txtid)
        {   
            var tb=document.getElementById(txtid);
            var txt=tb.value;
            if(event.keyCode==13)
            return true;

            if(event.keyCode==46)
            if(txt.indexOf('.')!=-1)
            event.keyCode=0;

            if((event.keyCode<46 || event.keyCode>57) || event.keyCode==47)
            {event.keyCode=0;return false;}
            
            visibility();   
        }
        
        function Validation()
        {                       
            if(document.getElementById("ctl00_MyCPH1_txtRuleValue").value == "")
            {
                alert("Enter Service Tax Rule Value...");
                document.getElementById("ctl00_MyCPH1_txtRuleValue").focus();
                return false;
            }        
        }
                
        function visibility()
        {        
             document.getElementById("ctl00_MyCPH1_trMsg").style.display='none';
        }
        
    </script>

    <div>
        <br />
        <table width="1000" align="left">
            <tr>
                <td style="width: 996px">
                    <asp:Panel ID="pnlHeader" runat="server">
                        <table border="0" cellpadding="3" cellspacing="1" class="boxbg" style="width: 55%"
                            align="left">
                            <tr class="bgbluegrey">
                                <td colspan="2" class="bluefnt">
                                    <b>Service Tax Rule</b></td>
                            </tr>
                            <tr bgcolor="white">
                                <td style="width: 150px">
                                    <font class="blackfnt">Rule Value</font>
                                </td>
                                <td style="width: 250px" valign="middle">
                                    <asp:TextBox ID="txtRuleValue" runat="server" CausesValidation="True" Columns="20" MaxLength="6" 
                                        BorderStyle="Groove" CssClass="blackfnt" onkeypress="javascript:return validFloat(event,this.getAttribute('id'));"></asp:TextBox>
                                </td>
                            </tr>
                            <tr bgcolor="white">
                                <td style="width: 150px">
                                    <font class="blackfnt">Rule Type</font>
                                </td>
                                <td style="width: 250px">
                                    <asp:DropDownList ID="ddlRuleType" runat="server" CssClass="blackfnt" onchange="javascript:return visibility();">
                                        <asp:ListItem Value="Y">Yes</asp:ListItem>
                                        <asp:ListItem Value="N">No</asp:ListItem>
                                    </asp:DropDownList></td>
                            </tr>
                            <tr bgcolor="white">
                                <td colspan="2" style="text-align: center">
                                    <asp:Button ID="btnApply" runat="server" OnClientClick="javascript:return Validation()"
                                        Text="Apply" CssClass="blackfnt" OnClick="btnApply_Click" />
                                </td>
                            </tr>
                            <tr bgcolor="white" runat="server" id="trMsg" visible="false">
                                <td colspan="2" style="text-align:left">
                                     <asp:Label ID="lblMsg" ForeColor="Red" Font-Bold="True" runat="server"></asp:Label>
                                </td>
                            </tr>
                        </table>
                    </asp:Panel>
                </td>
            </tr>
        </table>
        <br />
    </div>
    <div id="testdiv1" style="position: absolute; visibility: hidden; background-color: white;
        z-index: 99;">
    </div>
</asp:Content>
