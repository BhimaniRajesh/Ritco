<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/GUI/MasterPage.master"
    CodeFile="octCustBillStep1.aspx.cs" Inherits="octroi_octCustBillStep1" %>
   
<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">
<script language="javascript" type="text/javascript">
  function nwOpen()
        {
            window.open("popup-CUST.aspx","pbr","menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=387,height=220,status=no,left=220,top=70")
        }
        
            
        
function checklocation(obj)
        {
        
        var a;
        a=1;
     obj.value = obj.value.toUpperCase()
        //str=str.toUpperCase()
        
        if(obj.value != "")
        {
       for(i=0;i<str.length;i++)
       {
       
       str[i]=str[i].toUpperCase()

            if(obj.value==str[i])
            {
                 a=2
                  break;
               
                
            }
            else
            { 
               
                continue
            }
       }
      
       if(a!=2)
       {
             alert("Invalid Customer Code.")
           obj.focus();
       }
       }
 

}   


        </script>
    <br />
    <table align="left" style="width: 1100px">
        <tr>
            <td align="left">
                <a><font class="blklnkund"><b>Module</b></font></a> <b>&gt; </b><a><font class="blklnkund">
                    <b>Finance</b></font> </a><b>&gt; </b><a><font class="blklnkund"><b>Octroi</b></font>
                        <b>&gt; </b></a><a><font class="bluefnt"><b>Prepare Octroi Bill </b></font></a>
            </td>
        </tr>
    </table>
    <br />
    <br />
    <br />
    <table border="0" cellpadding="1" cellspacing="1" class="boxbg" style="width: 55%"
        align="center">
        <tr bgcolor="white">
            <td style="width: 190px">
                <font class="blackfnt">Enter Customer Code </font>
            </td>
            <td style="width: 376px">
                <asp:TextBox ID="Party_code" runat="server" CausesValidation="True" Columns="50" onblur="return checklocation(this)"
                    Width="169px"></asp:TextBox><asp:Label ID="Label1" runat="server" BorderStyle="Groove" TabIndex="18" Text='<a href="javascript:nwOpen()">...</a>'
                    Width="14px"></asp:Label>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="Party_code"
                    ErrorMessage="Plz Enter Customer Code" CssClass="blackfnt"></asp:RequiredFieldValidator>
                <%--<atlas:AutoCompleteExtender runat="server" ID="Extender1">
                    <atlas:AutoCompleteProperties Enabled="True" TargetControlID="Party_code" ServiceMethod="GetCustomerList"
                        ServicePath="../services/WebService.asmx" MinimumPrefixLength="1" />
                </atlas:AutoCompleteExtender>--%>
                
                <ajaxToolkit:AutoCompleteExtender ID="Extender1" runat="server" Enabled="True" MinimumPrefixLength="1"
                    ServiceMethod="GetCustomerList" CompletionListItemCssClass="autocomplete_listItem"
                    CompletionListHighlightedItemCssClass="autocomplete_highlightedListItem" ServicePath="../services/WebService.asmx"
                    TargetControlID="Party_code">
                </ajaxToolkit:AutoCompleteExtender>
                
                &nbsp;
            </td>
        </tr>
        <tr bgcolor="white">
            <td style="width: 190px">
                <font class="blackfnt">Above Customer is </font>
            </td>
            <td style="width: 376px">
                <asp:DropDownList ID="Billto" runat="server">
                    <asp:ListItem Value="CSGN">Consignor</asp:ListItem>
                    <asp:ListItem Value="CSGE">Consignee</asp:ListItem>
                    <asp:ListItem Value="BILL">Billing Party </asp:ListItem>
                </asp:DropDownList></td>
        </tr>
    </table>
    <br />
    <center>
        <asp:Button ID="submit1" runat="server" OnClick="submit1_Click" Text="Submit" />
    </center>
</asp:Content>
