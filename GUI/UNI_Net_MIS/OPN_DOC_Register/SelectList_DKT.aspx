<table id="tbl_dkt" style="width: 8.5in; display: block;" class="boxbg" runat="server" 
    border="0" align="left" cellpadding="1" cellspacing="1">
    <tr style="background-color: white">
        <td align="left" width="400">
            <asp:label id="Label6" cssclass="blackfnt" text="Select Mode" runat="server" width="100%"></asp:label>
        </td>
        <td align="left">
            <asp:dropdownlist id="DDLMode" runat="server">
                                </asp:dropdownlist>
        </td>
    </tr>
    <tr style="background-color: white">
        <td align="left" width="400">
            <asp:label id="Label71" cssclass="blackfnt" text="Select Paybasis" runat="server"
                width="100%"></asp:label>
        </td>
        <td align="left">
            <asp:dropdownlist id="DDLPaybas" runat="server">
                                </asp:dropdownlist>
        </td>
    </tr>
     <tr style="background-color: white">
        <td align="left" width="400">
            <asp:label id="Label712" cssclass="blackfnt" text="Select Business Type" runat="server"
                width="100%"></asp:label>
        </td>
        <td align="left">
            <asp:dropdownlist id="DDLBusTyp" runat="server">
                                </asp:dropdownlist>
        </td>
    </tr>
    <tr style="background-color: white">
        <td align="left">
            <asp:label id="Label3" cssclass="blackfnt" text="Select Service Type" runat="server"
                width="164px"></asp:label>
        </td>
        <td align="left" valign="top">
            <asp:dropdownlist id="DDLType" runat="server">
                            
                            </asp:dropdownlist>
        </td>
    </tr>
    <tr style="background-color: white">
        <td align="left">
            <asp:label id="Label11" runat="server" cssclass="blackfnt" text="Select Status" width="100px"></asp:label>
        </td>
        <td align="left" valign="top">
            <asp:dropdownlist id="DDStatus" runat="server">
                                <asp:ListItem Text="All" Value="All"></asp:ListItem>
                                <%--<asp:ListItem Text="Operational" Value="0"></asp:ListItem>
                                <asp:ListItem Text="Quick" Value="10"></asp:ListItem>
                                <asp:ListItem Text="Non Financial" Value="11"></asp:ListItem>
                                <asp:ListItem Text="Financial" Value="1"></asp:ListItem>--%>
                                <asp:ListItem Text="Quick" Value="10"></asp:ListItem>
                                <asp:ListItem Text="Financial" Value="1"></asp:ListItem>
                                <asp:ListItem Text="Billed" Value="2"></asp:ListItem>
                                <asp:ListItem Text="Un Billed" Value="3"></asp:ListItem>
                                <asp:ListItem Text="MR - Not Generated" Value="4"></asp:ListItem>
                                <asp:ListItem Text="MR - Generated" Value="5"></asp:ListItem>
                                <asp:ListItem Text="Octroi Paid" Value="6"></asp:ListItem>
                                <asp:ListItem Text="Octroi Not Paid" Value="7"></asp:ListItem>
                                <asp:ListItem Text="Delivered" Value="8"></asp:ListItem>
                                <asp:ListItem Text="Not Delivered" Value="9"></asp:ListItem>
                                <asp:ListItem Text="Door Pickup - Door Delivery" Value="12"></asp:ListItem>
                                <asp:ListItem Text="Door Pickup - Godown Delivery" Value="13"></asp:ListItem>
                                <asp:ListItem Text="Godown Pickup - Godown  Delivery" Value="14"></asp:ListItem>
                                <asp:ListItem Text="Godown Pickup - Door Delivery" Value="15"></asp:ListItem>
                                <asp:ListItem Text="Cancel" Value="16"></asp:ListItem>
                                <asp:ListItem Text="All" Value="All"></asp:ListItem>
                            </asp:dropdownlist>
        </td>
    </tr>
    <%--<tr style="background-color: white">
        <td align="left">
            <asp:label id="Labelyiled" runat="server" cssclass="blackfnt" text="Select Yield Range"
                width="128px"></asp:label>
        </td>
        <td align="left" valign="top">
            <asp:label id="Label14" cssclass="blackfnt" runat="server" text=" From: "></asp:label>
            <asp:textbox id="Yield1" runat="Server" validationgroup="VGDtFromTo" width="80"></asp:textbox>
            <asp:label id="Label15" cssclass="blackfnt" runat="server" text=" To: "></asp:label>
            <asp:textbox id="Yield2" runat="Server" validationgroup="VGDtFromTo" width="80"></asp:textbox>
        </td>
    </tr>--%>
    <tr style="background-color: white">
        <td align="left">
            <asp:label id="LabeCust" runat="server" cssclass="blackfnt" text="Enter Customer Code"
                width="136px"></asp:label>
        </td>
        <td align="left" valign="top">
        <asp:dropdownlist id="custcd" runat="server">
                                </asp:dropdownlist>
            <%--<asp:textbox id="custcd" runat="Server" width="80"></asp:textbox>--%>
           <%-- <input id="btnBranchPopup" runat="server" onclick="BranchPopup('../Popup_cust.aspx?13')"
                type="button" value="..." />--%></td>
    </tr>
</table>
<table id="tbl_thc" style="width: 8.5in; display: none;" class="boxbg" runat="server" 
    border="0" align="left" cellpadding="1" cellspacing="1">
    <tr style="background-color: white">
        <td align="left" width="400">
            <asp:label id="Label6routr" cssclass="blackfnt" text="Select Route" runat="server" width="100%"></asp:label>
        </td>
        <td align="left">
            <asp:dropdownlist id="DDLROute" runat="server">
                                </asp:dropdownlist>
        </td>
    </tr>
    <tr style="background-color: white">
        <td align="left" width="400">
            <asp:label id="Labelvendthc" cssclass="blackfnt" text="Select Vendor" runat="server"
                width="100%"></asp:label>
        </td>
        <td align="left">
            <asp:dropdownlist id="DDLVendor_thc" runat="server">
                                </asp:dropdownlist>
        </td>
    </tr>
    <tr style="background-color: white">
        <td align="left" width="400">
            <asp:label id="LabeSt" cssclass="blackfnt" text="Select Staus" runat="server"
                width="100%"></asp:label>
        </td>
        <td align="left">
            <asp:dropdownlist id="DDLStatus_thc" runat="server">
            <asp:ListItem Value="All" Text="All"></asp:ListItem>
            <asp:ListItem Value="1" Text="Contract Entry Made"></asp:ListItem>
            <asp:ListItem Value="2" Text="Advance Made"></asp:ListItem>
            <asp:ListItem Value="3" Text="Bill Entry Done"></asp:ListItem>
            <asp:ListItem Value="4" Text="Financial Close"></asp:ListItem>
                                </asp:dropdownlist>
        </td>
    </tr>
</table>

<table id="tbl_prs" style="width: 8.5in; display: none;" class="boxbg" runat="server"
    border="0" align="left" cellpadding="1" cellspacing="1">
   
   
    <tr style="background-color: white">
        <td align="left" width="400">
            <asp:label id="LabelvendPRS" cssclass="blackfnt" text="Select Vendor" runat="server"
                width="100%"></asp:label>
        </td>
        <td align="left">
            <asp:dropdownlist id="DDLVendor_PRS" runat="server">
                                </asp:dropdownlist>
        </td>
    </tr>
   
</table>
