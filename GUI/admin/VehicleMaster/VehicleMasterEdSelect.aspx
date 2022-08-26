<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true" CodeFile="VehicleMasterEdSelect.aspx.cs" Inherits="GUI_admin_VehicleMaster_VehicleMasterEdSelect" Title="Untitled Page" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">
    <script language="javascript" type="text/javascript">
        function vehiclecheck(str) {
            if (document.getElementById(str).value != "") {
                document.getElementById(str).value = trimAll(document.getElementById(str).value)
                document.getElementById(str).value = document.getElementById(str).value.toUpperCase()
                var p = "1"
                for (i = 0; i < vehno.length; i++) {

                    if (document.getElementById(str).value == vehno[i]) {
                        //alert("Vehicle already exists !!")
                        p = "2"
                        //return false                       
                    }

                }
                if (p == "1") {
                    alert("This vehicle is not registred !!")
                    document.getElementById(str).focus()
                    return false
                }
            }
            else {
                return false
            }
        }
        function trimAll(strValue) {
            //Trimming left most white space characters
            while (strValue.substring(0, 1) == ' ') {
                strValue = strValue.substring(1, strValue.length);
            }
            //Trimming right most white space characters
            while (strValue.substring(strValue.length - 1, strValue.length) == ' ') {
                strValue = strValue.substring(0, strValue.length - 1);
            }

            return strValue;
        }
        function nwOpen(mNo) {
            window.open("popup-Vehicle.aspx?" + mNo, "pbr", "menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=387,height=220,status=no,left=220,top=70")
        }
        function chkVal(strPrompt) {

            if (document.getElementById("ctl00$MyCPH1$ddVendorName").value == "--Select--") {
                alert("Please select Vendor Name");
                document.getElementById("ctl00$MyCPH1$ddVendorName").focus();
                return false;
            }
            else if (document.getElementById("ctl00$MyCPH1$ddVehicleNumber").value == "--Select--") {
                alert("Please select Vehicle Number");
                document.getElementById("ctl00$MyCPH1$ddVehicleNumber").focus();
                return false;
            }

            //if (del(strPrompt) == false) {
            //    return false;
            //}

            return true;
        }

        function chkCst(strPrompt) {
            if (document.getElementById("ctl00$MyCPH1$txtVehicleNo").value == "") {
                alert("Please select Vehicle Number");
                document.getElementById("ctl00$MyCPH1$txtVehicleNo").focus();
                return false;
            }
            //        else if(document.getElementById("ctl00$MyCPH1$txtVndrCd").value == "--Select--")
            //        {
            //             alert("Please select Vendor Code");
            //             document.getElementById("ctl00$MyCPH1$txtVndrCd").focus();
            //             return false;
            //        }  

            //if (del(strPrompt) == false) {
            //    return false;
            //}
            //else {
                return true;
            //}
        }

        function abc(strPrompt) {
            //debugger
            if (document.getElementById("ctl00$MyCPH1$ddVendorName").value == "--Select--") {
                alert("Please select Vendor Name");
                document.getElementById("ctl00$MyCPH1$ddVendorName").focus();
                return false;
            }
            else if (document.getElementById("ctl00$MyCPH1$ddVehicleNumber").value == "--Select--") {
                alert("Please select Vehicle Number");
                document.getElementById("ctl00$MyCPH1$ddVehicleNumber").focus();
                return false;
            }

            //if (del(strPrompt) == false) {
            //    return false;
            //}

            return true;
        }
    </script>

    <script language="vbscript" type="text/vbscript">
 
    Function del(Prompt)
    
        if MsgBox (Prompt, vbYesNo, "Confirmation") = vbYes then
            del = true
        else
            del = false
        end if
           
    End Function
    
    </script>


    <table width="100%" border="0" cellpadding="0" cellspacing="0">
        <tr>
            <td>
                <table border="0" align="center" cellpadding="0" cellspacing="0" style="width: 100%; height: 228px">
                    <tr>
                        <td style="height: 36px"><a><font class="blklnkund"><strong>Module</strong></font></a>

                            &gt; <a><font class="blklnkund"><strong>Administrator </strong></font></a>

                            &gt; <a href="../operations.aspx"><font class="blklnkund"><strong>Operations</strong></font></a>

                            <font class="bluefnt"><strong>&gt; 
		  Vehicle Master</strong> </font></td>
                    </tr>
                    <tr>
                        <td class="horzblue">
                            <img src="../../images/clear.gif" width="2" height="1" alt="" /></td>
                    </tr>
                    <%--<tr> 
          <td><img src="../../images/clear.gif" width="15" height="10" alt="" /></td>
        </tr>--%>

                    <tr>
                        <td align="right" style="height: 51px"><a href="javascript:window.history.go(-1)" title="back">
                            <img src="../../images/back.gif" border="0" alt="" /></a></td>
                    </tr>
                    <tr>
                        <td align="right"></td>
                    </tr>
                    <tr>
                        <td align="right"></td>
                    </tr>

                    <tr>
                        <td>
                            <!--START-->
                            <br />
                            <table border="0" cellpadding="3" width="76%" cellspacing="1" align="center" class="boxbg">
                                <tr class="bgbluegrey">
                                    <td align="center" colspan="2">
                                        <p align="center"><font class="blackfnt"><b>Quick Edit/Delete Vehicle</b></font></p>
                                    </td>
                                </tr>
                                <tr bgcolor="#FFFFFF">
                                    <td align="center" width="40%" style="height: 30px">
                                        <div align="right">
                                            <font class="blackfnt">Enter Vehicle Number</font>
                                            :
                                        </div>
                                    </td>
                                    <td bgcolor="#FFFFFF" align="left" style="height: 30px">
                                        <asp:TextBox ID="txtVehicleNo" onblur="return vehiclecheck('ctl00_MyCPH1_txtVehicleNo')" runat="server"></asp:TextBox>
                                        <asp:Label ID="Label1" runat="server" BorderStyle="Groove" TabIndex="18" Text='<a href="javascript:nwOpen(1)">...</a>'
                                            Width="14px"></asp:Label></td>
                                </tr>

                                <tr>
                                    <td bgcolor="#FFFFFF" align="center" colspan="2" height="22"><font class="blackfnt"><b>
                                        <asp:Button ID="btnQckAdd" runat="server" Text="Add" OnClick="btnQckAdd_Click" />
                                        <asp:Button ID="btnQckEdit" runat="server" Text="Edit" OnClientClick="return chkCst('Edit')" OnClick="btnQckEdit_Click" />&nbsp;
            <asp:Button ID="btnQckDelete" runat="server" Text="Delete" OnClientClick="return chkCst('Delete')" OnClick="btnQckDelete_Click" />
                                        <asp:Button ID="btnQckLstAll" runat="server" Text="ListAll" OnClick="btnQckLstAll_Click" /></b></font></td>
                                </tr>
                            </table>
                            <br />
                            <br />

                            <table border="0" cellpadding="3" width="76%" bgcolor="#808080" cellspacing="1" align="center" class="boxbg">
                                <tr class="bgbluegrey">
                                    <td align="center" colspan="2">
                                        <p align="center"><font class="blackfnt"><b>Select Vehicle for Edit/Delete</b></font></p>
                                    </td>
                                </tr>
                                <tr bgcolor="#FFFFFF">
                                    <td align="center" width="40%">
                                        <div align="right"><font class="blackfnt">Select Vehicle Typee</font> : </div>
                                    </td>
                                    <td bgcolor="#FFFFFF" align="left">
                                        <asp:UpdatePanel ID="up1" runat="server">
                                            <ContentTemplate>
                                                <asp:DropDownList ID="ddVendorName" runat="server" AutoPostBack="True" OnSelectedIndexChanged="ddVendorName_SelectedIndexChanged">
                                                </asp:DropDownList>
                                            </ContentTemplate>

                                        </asp:UpdatePanel>
                                    </td>
                                </tr>

                                <tr bgcolor="#FFFFFF">
                                    <td align="center" valign="top">
                                        <div align="right"><font class="blackfnt">Select Vehicle Number</font> : </div>
                                    </td>
                                    <td bgcolor="#FFFFFF" align="left">
                                        <asp:UpdatePanel ID="up2" runat="server">
                                            <ContentTemplate>
                                                <asp:DropDownList ID="ddVehicleNumber" runat="server">
                                                </asp:DropDownList>
                                            </ContentTemplate>
                                            <Triggers>
                                                <asp:AsyncPostBackTrigger ControlID="ddVendorName" EventName="SelectedIndexChanged" />
                                            </Triggers>
                                        </asp:UpdatePanel>
                                        <asp:Label ID="lblMsg1" runat="server" ForeColor="#FF8080"></asp:Label></td>
                                </tr>
                                <tr>
                                    <td bgcolor="#FFFFFF" align="center" colspan="2" height="22">
                                        <%--<asp:UpdatePanel ID="upAdd" runat="server">
           <ContentTemplate>--%>
                                        <asp:Button ID="btnAdd" runat="server" Text="Add" OnClick="btnAdd_Click" />
                                        <asp:Button ID="btnEdit" runat="server" Text="Edit" OnClientClick="return chkVal('Edit')" OnClick="btnEdit_Click" />
                                        <asp:Button ID="btnDelete" runat="server" Text="Delete" OnClientClick="return abc('Delete')" OnClick="btnDelete_Click" />
                                        <asp:Button ID="btnListing" runat="server" OnClick="btnListing_Click" Text="Listing" /><%--</ContentTemplate>
            <Triggers>
              <asp:AsyncPostBackTrigger ControlID="btnAdd" EventName="Click" />
              <asp:AsyncPostBackTrigger ControlID="btnEdit" EventName="Click" />
              <asp:AsyncPostBackTrigger ControlID="btnDelete" EventName="Click" />
            </Triggers>
          </asp:UpdatePanel>--%></td>
                                </tr>
                            </table>


                            <!--END-->
                        </td>
                    </tr>
                    <tr>
                        <td>&nbsp;</td>
                    </tr>
                    <tr>
                        <td></td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
</asp:Content>

