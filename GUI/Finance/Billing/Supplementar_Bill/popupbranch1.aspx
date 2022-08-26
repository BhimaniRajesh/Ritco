<%@ Page Language="C#" AutoEventWireup="true" CodeFile="popupbranch1.aspx.cs" Inherits="popupbranch" %>


<link href="../../../../GUI/images/style.css" rel="stylesheet" type="text/css" />
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Customer List</title>
    
    <script language="javascript" type="text/javascript">
        
        function SelectLocation(objLocation)
        {
            var mNo = "<%=strQSParam %>"
            
            if(mNo == "1")
                window.opener.document.forms[0].ctl00$MyCPH1$txtparty.value = objLocation.value
            else if(mNo == "2")
                window.opener.document.forms[0].ctl00$MyCPH1$txtbillcolbranch.value = objLocation.value
            else
                window.opener.document.forms[0].ctl00$MyCPH1$txtsubbranch.value = objLocation.value
                
            
            //    window.opener.document.forms[0].ctl00$MyCPH1$txtcust.value = objLocation.value
             window.close();
            
        }
          function ConvertToUpper(objCustomer)
            {
                if(document.getElementById(objCustomer.id))
                {
                    if(document.getElementById(objCustomer.id).value != "")
                    {
                        document.getElementById(objCustomer.id).value = document.getElementById(objCustomer.id).value.toUpperCase()
                    }
                }
            }
            
        
    </script>
    
</head>
<body>
    <form id="form1" runat="server">
    <table border="1" width="85%" cellspacing="1" cellpadding="2">
                <tr class="bgbluegrey">
                    <td colspan="2" align="center" style="height: 20px">
                        <label id="lblParameter" class="blackfnt">
                            Search by parameter
                        </label>
                    </td>
                </tr>
                
                <tr>
                    <td align="left">
                        <label id="lblCustCode" class="blackfnt">
                            Location Code
                        </label>
                    </td>
                    
                    <td align="left">
                        &nbsp;
                        <input type="text" id="txtVendorCode" runat="server" onblur= "ConvertToUpper(this)" class="inp"/>
                    </td>
                </tr>
                
                <tr>
                    <td align="left">
                        <label id="lblCustName" class="blackfnt">
                            Loaction Name
                        </label>
                    </td>
                    
                    <td align="left">
                        &nbsp;
                        <input type="text" id="txtVendorName" runat="server"  class="inp"/>
                    </td>
                </tr>
                
                <tr>
                    <td colspan="2" align="center">
                        <asp:Button ID="btnSubmit" Text="Submit" OnClick="btnSubmit_OnClick" runat="server"/>
                    </td>
                </tr>
            </table>
    
                        <asp:GridView ID="GridView1" runat="server" AllowPaging="false" AllowSorting="true"
                            AutoGenerateColumns="false" BorderWidth="1" CellPadding="7" CellSpacing="1" EmptyDataText="No Records Found..." 
                            HeaderStyle-CssClass="dgHeaderStyle" PagerSettings-Mode="Numeric" PagerStyle-HorizontalAlign="left"
                            Width="350px" class="boxbg">
                            <Columns>
                                <asp:TemplateField HeaderText="Select" ItemStyle-BackColor="white" ItemStyle-Width="40px" >
                                    <ItemTemplate>
                                        <input name="MyRadioButton" type="radio" value='<%# Eval("LOCCODE") %>' onclick="SelectLocation(this)"/>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:BoundField DataField="loccode" HeaderText="Location Code">
                                    <ItemStyle CssClass="blackfnt" HorizontalAlign="Left" BackColor="white" Width="80px" />
                                    <HeaderStyle CssClass="bgpink" HorizontalAlign="Left" Wrap="False" />
                                </asp:BoundField>
                                <asp:BoundField DataField="locname" HeaderText="Location Name">
                                    <ItemStyle CssClass="blackfnt" HorizontalAlign="Left" BackColor="white"/>
                                    <HeaderStyle CssClass="bgpink" HorizontalAlign="Left" Wrap="False" />
                                </asp:BoundField>
                              </Columns>
                            <PagerStyle HorizontalAlign="Left" />
                            <HeaderStyle CssClass="dgHeaderStyle" />
                        </asp:GridView>
                   
        &nbsp;
    <div>
        &nbsp;</div>
    </form>
</body>
</html>


                             
