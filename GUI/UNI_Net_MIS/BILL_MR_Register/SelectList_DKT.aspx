<table id="tbl_BILL" class="boxbg" runat="server" style="width: 8.5in; display: block;"
    border="0" align="left" cellpadding="1" cellspacing="1">
    <tr style="background-color: white">
        <td align="left" width="300">
            <font class="blackfnt">Select Bill Type</font>
        </td>
        <td align="left">
            <asp:dropdownlist id="Bill_Type" runat="server">
                                </asp:dropdownlist>
        </td>
    </tr>
    <tr style="background-color: white">
        <td align="left" width="300">
            <font class="blackfnt">Select Bill Status</font>
        </td>
        <td align="left">
            <asp:dropdownlist id="BILL_Status" runat="server">
         <asp:ListItem Text="All" Value="All" ></asp:ListItem>
         <asp:ListItem Text="Submitted- Due" Value="1" ></asp:ListItem>
         <asp:ListItem Text="Submitted � Not Due" Value="2" ></asp:ListItem>
           <asp:ListItem Text="Unsubmitted � Due" Value="3" ></asp:ListItem>
           <asp:ListItem Text="Unsubmitted � Not Du" Value="4" ></asp:ListItem>
           <asp:ListItem Text="Cancelled" Value="6" ></asp:ListItem>
           <asp:ListItem Text="Collected" Value="5" ></asp:ListItem>
           <asp:ListItem Text="Not-Collected" Value="5A" ></asp:ListItem>
                                </asp:dropdownlist>
        </td>
    </tr>
    <tr style="background-color: white">
        <td align="left" width="300">
            <font class="blackfnt">Select BIll List Type</font>
        </td>
        <td align="left">
            <asp:dropdownlist id="Bill_List_Type" runat="server">
         <asp:ListItem Text="All" Value="All" ></asp:ListItem>
         <asp:ListItem Text="With Service Tax + Cess + H.Cess" Value="1" ></asp:ListItem>
         <asp:ListItem Text="W/O Service Tax + Cess + H.Cess" Value="2" ></asp:ListItem>
                                </asp:dropdownlist>
        </td>
    </tr>
    <tr style="background-color: white">
        <td align="left" width="300">
            <font class="blackfnt">Cash/Cheque</font>
        </td>
        <td align="left">
            <asp:dropdownlist id="Bill_CL_Type" runat="server">
        <asp:ListItem Text="All" Value="All" ></asp:ListItem>
         <asp:ListItem Text="Cash" Value="Cash" ></asp:ListItem>
         <asp:ListItem Text="Cheque" Value="Cheque" ></asp:ListItem>
                                </asp:dropdownlist>
        </td>
    </tr>
    <tr style="background-color: white; visible: none;">
        <td align="left" width="300">
            <font class="blackfnt">Over Due Days :</font>
        </td>
        <td align="left">
            <asp:textbox runat="server" text="0.00" onkeypress="validFloat(event,this.getAttribute('id'))"
                id="Days" width="100" maxlength="10"> </asp:textbox>
        </td>
    </tr>
    <tr style="background-color: white">
        <td align="left" width="300">
            <font class="blackfnt">Amount Greater Than :</font>
        </td>
        <td align="left">
            <asp:textbox runat="server" text="0.00" onkeypress="validFloat(event,this.getAttribute('id'))"
                id="BillAMT" width="100" maxlength="10"> </asp:textbox>
        </td>
    </tr>
    <tr style="background-color: white">
        <td align="center" colspan="2">
            <font class="blackfnt">OR</font>
        </td>
    </tr>
    <tr style="background-color: white">
        <td align="left">
            <font class="blackfnt">BILL No.</font>
        </td>
        <td align="left" style="width: auto;">
            <asp:textbox runat="server" text="" id="txtbillno" width="250"> </asp:textbox>
            <font class="blackfnt">[seperated by <i>comma</i> if multiple]</font>
        </td>
    </tr>
    <tr style="background-color: white">
        <td align="left">
            <font class="blackfnt">Manual BILL No.</font>
        </td>
        <td align="left" style="width: auto;">
            <asp:textbox runat="server" text="" id="txtMAnbillno" width="250"> </asp:textbox>
            <font class="blackfnt">[seperated by <i>comma</i> if multiple]</font>
        </td>
    </tr>
    <tr style="background-color: white">
        <td align="left">
            <font class="blackfnt">
                <%=dkt_Call%>
                No.</font>
        </td>
        <td align="left" style="width: auto;">
            <asp:textbox runat="server" text="" id="txtDKTno" width="250"> </asp:textbox>
            <font class="blackfnt">[seperated by <i>comma</i> if multiple]</font>
        </td>
    </tr>
</table>
<table id="tbl_MR" class="boxbg" runat="server" style="width: 8.5in; display: none"
    border="0" align="left" cellpadding="1" cellspacing="1">
    <tr style="background-color: white">
        <td align="left" width="300">
            <font class="blackfnt">Select MR Type</font>
        </td>
        <td align="left">
            <asp:dropdownlist id="MR_Type" runat="server">
                                </asp:dropdownlist>
        </td>
    </tr>
    <tr style="background-color: white">
        <td align="left" width="300">
            <font class="blackfnt">Select
                <%=dkt_Call%>
                Status</font>
        </td>
        <td align="left">
            <asp:dropdownlist id="DKT_STATS" runat="server">
         <asp:ListItem Text="All" Value="All" ></asp:ListItem>
         <asp:ListItem Text="Delivered" Value="1" ></asp:ListItem>
         <asp:ListItem Text="Yet Not Delivered" Value="2" ></asp:ListItem>
                                </asp:dropdownlist>
        </td>
    </tr>
    <tr style="background-color: white">
        <td align="left" width="300">
            <font class="blackfnt">Select MR Status</font>
        </td>
        <td align="left">
            <asp:dropdownlist id="MR_Status" runat="server">
         <asp:ListItem Text="All" Value="All" ></asp:ListItem>
         <asp:ListItem Text="Closed" Value="1" ></asp:ListItem>
         <asp:ListItem Text="Generated" Value="2" ></asp:ListItem>
           <asp:ListItem Text="Cancelled" Value="3" ></asp:ListItem>
                                </asp:dropdownlist>
        </td>
    </tr>
    <tr style="background-color: white">
        <td align="left" width="300">
            <font class="blackfnt">Select MR List Type</font>
        </td>
        <td align="left">
            <asp:dropdownlist id="MR_List_Type" runat="server">
         <asp:ListItem Text="All" Value="All" ></asp:ListItem>
         <asp:ListItem Text="With Service Tax + Cess + H.Cess" Value="1" ></asp:ListItem>
         <asp:ListItem Text="W/O Service Tax + Cess + H.Cess" Value="2" ></asp:ListItem>
                                </asp:dropdownlist>
        </td>
    </tr>
    <tr style="background-color: white">
        <td align="left" width="300">
            <font class="blackfnt">Cash/Cheque</font>
        </td>
        <td align="left">
            <asp:dropdownlist id="MR_CL_Type" runat="server">
        <asp:ListItem Text="All" Value="All" ></asp:ListItem>
         <asp:ListItem Text="Cash" Value="Cash" ></asp:ListItem>
         <asp:ListItem Text="Cheque" Value="Cheque" ></asp:ListItem>
                                </asp:dropdownlist>
        </td>
    </tr>
    <tr style="background-color: white">
        <td align="left" width="300">
            <font class="blackfnt">Amount Greater Than :</font>
        </td>
        <td align="left">
            <asp:textbox runat="server" text="0.00" onkeypress="validFloat(event,this.getAttribute('id'))"
                id="MRSAMT" width="100" maxlength="10"> </asp:textbox>
        </td>
    </tr>
    <tr style="background-color: white">
        <td align="center" colspan="2">
            <font class="blackboldfnt">OR</font>
        </td>
    </tr>
    <tr style="background-color: white">
        <td align="left">
            <font class="blackfnt">MR No.</font>
        </td>
        <td align="left" style="width: auto;">
            <asp:textbox runat="server" text="" id="txtMRno" width="250"> </asp:textbox>
            <font class="blackfnt">[seperated by <i>comma</i> if multiple]</font>
        </td>
    </tr>
    <tr style="background-color: white">
        <td align="left">
            <font class="blackfnt">
                <%=dkt_Call%>
                No.</font>
        </td>
        <td align="left" style="width: auto;">
            <asp:textbox runat="server" text="" id="txtDKTno_MR" width="250"> </asp:textbox>
            <font class="blackfnt">[seperated by <i>comma</i> if multiple]</font>
        </td>
    </tr>
</table>
