<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true" CodeFile="CustomerMaster.aspx.cs" Inherits="GUI_admin_CustomerMaster_CustomerMaster" Title="Untitled Page" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">
    <script language="javascript" type="text/javascript">
        function nwOpen(mNo) {
            window.open("popup-CUST.aspx?" + mNo, "pbr", "menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=387,height=220,status=no,left=220,top=70")
        }
        function chkVal() {
            //debugger
            if (document.getElementById("ctl00$MyCPH1$ddCstGrp").value == "--Select--") {
                alert("Please select Customer Group");
                document.getElementById("ctl00$MyCPH1$ddCstGrp").focus();
                return false;
            }

            return true;
        }



        function chkVal2() {
            //debugger
            if (document.getElementById("ctl00$MyCPH1$ddCstGrp").value == "--Select--") {
                alert("Please select Customer Group");
                document.getElementById("ctl00$MyCPH1$ddCstGrp").focus();
                return false;
            }
            

            if (document.getElementById("ctl00_MyCPH1_txtCustomerCode").value == "") {
                alert("Please select Customer");
                document.getElementById("ctl00_MyCPH1_txtCustomerCode").focus();
                return false;
            }

            if (document.getElementById("ctl00_MyCPH1_txtCustomerCode").value != document.getElementById("ctl00_MyCPH1_hdnCustomerCode").value) {
                alert("Please select Customer");
                document.getElementById("ctl00_MyCPH1_txtCustomerCode").focus();
                return false;
            }
            //if (document.getElementById("ctl00$MyCPH1$ddCst").value == "" || document.getElementById("ctl00$MyCPH1$ddCst").value == "--Select--") {
            //    alert("Please select Customer");
            //    document.getElementById("ctl00$MyCPH1$ddCst").focus();
            //    return false;
            //}

            return true;
        }


        function IsText(sText) {
            var ValidChars = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";
            var IsText = true;
            var Char;

            for (i = 0; i < sText.length && IsText == true; i++) {
                Char = sText.charAt(i);

                if (ValidChars.indexOf(Char) == -1) {
                    IsText = false;
                }
            }

            return IsText;
        }
        function chkCst() {
            if (document.getElementById("ctl00$MyCPH1$txtCstCd").value == "") {
                alert("Please select Customer Code");
                document.getElementById("ctl00$MyCPH1$txtCstCd").focus();
                return false;
            }
            else if (IsText(document.getElementById("ctl00_MyCPH1_txtCstCd").value) == false) {
                alert("Enter proper Customer Code");
                document.getElementById("ctl00_MyCPH1_txtCstCd").focus();
                return false;
            }

            return true;
        }
        function del() {
            alert("Sorry, deletion of customer is not allowed !!!")
        }


        var serviceUrl = '<%=ResolveClientUrl("~/services/WebxCommonService.asmx")%>';

        $(document).ready(function () {

            AutoCompleteForGSTMaster1("#ctl00_MyCPH1_txtCustomerCode", serviceUrl + '/CustomerMasterAutoComplate', 'POST', 'application/json; charset=utf-8', 'json',
                      'searchText', 'l', 'v', 'l', 'v', 'v', "ctl00_MyCPH1_hdnCustomerCode", 'No entries found!', 2, 'GroupCode=ctl00_MyCPH1_ddCstGrp', true);

            //Sys.WebForms.PageRequestManager.getInstance().add_endRequest(EndRequestHandler);
            //function EndRequestHandler(sender, args) {
            //    AutoCompleteForGSTMaster($("#ctl00_MyCPH1_txtCustomerCode"), serviceUrl + '/CustomerMasterAutoComplate', 'POST', 'application/json; charset=utf-8', 'json',
            //          'searchText', 'l', 'l', 'l', 'v', 'v', "ctl00_MyCPH1_hdnCustomerCode", 'No entries found!', 2, 'GroupCode=ctl00_MyCPH1_ddCstGrp', true);
            //};

        });


        //common Autocomplete method for GST Master
        function AutoCompleteForGSTMaster1(eleId, url, type, contentType, dataType, prefixText, focus, select, s1, s2, EvalOrtext, eleVal, alertMsg, minPrefixLength, additionalData, disableNotFoundAlert) {
            
            $(eleId).autocomplete({
                minLength: minPrefixLength,
                source: function (request, response) {

                    var requestData, svcUrl;

                    type = type.toUpperCase();
                    if (type == "POST") {
                        requestData = "{'" + prefixText + "': '" + request.term + "'";

                        if (additionalData != undefined && additionalData != null) {
                            var addData = additionalData.split(',');
                            for (var i = 0; i < addData.length; i++) {
                                var keyval = addData[i].split('=');
                                requestData += (", '" + keyval[0] + "': '" + $('#' + keyval[1]).val() + "'");
                            }
                        }
                        requestData += "}";
                        svcUrl = url;
                    }
                    else {
                        svcUrl = url + "?" + prefixText + "=" + request.term;
                    }

                    $.ajax({
                        type: type,
                        contentType: contentType,
                        url: svcUrl,
                        dataType: dataType,
                        data: requestData,
                        success: function (data) {
                            if (data.d.length != 0) {
                                var retOut;
                                try {
                                    retOut = jQuery.parseJSON(data.d);
                                } catch (e) { retOut = data.d; }

                                response($.map(retOut, function (item) {
                                    return {
                                        label: item.Name,
                                        value: item.Value
                                    }
                                }));
                            } else {
                                if (disableNotFoundAlert == undefined || disableNotFoundAlert == null || disableNotFoundAlert == false) {
                                    alert(alertMsg);
                                }
                                $(eleId).val("");
                                $("#" + eleVal).val('');
                            }
                        },
                        error: function (errormessage) {
                            alert(errormessage.message);
                        }
                    })
                },
                open: function (event, ui) { disableACblur = true; return false; },
                close: function (event, ui) { disableACblur = false; return false; },
                focus: function (event, ui) {
                    if (focus == 'v') { $(this).val(ui.item.value); }
                    else if (focus == 'l') { $(this).val(ui.item.label); }
                    else { $(this).val(ui.item.label + " : " + ui.item.value); }
                    return false;
                },
                select: function (event, ui) {
                    if (select == 'v') { $(this).val(ui.item.value); $("#" + eleVal).val(ui.item.value); }
                    else if (select == 'l') { $(this).val(ui.item.label); $("#" + eleVal).val(ui.item.value); }
                    else { $(this).val(ui.item.label + " : " + ui.item.value); $("#" + eleVal).val(ui.item.value); }

                    if (EvalOrtext == 'v') { $("#" + eleVal).val(ui.item.value); }
                    else { $("#" + eleVal).val(ui.item.label); }

                    return false;
                }
            })
            .data("ui-autocomplete")._renderItem = function (ul, item) {
                var rs1, rs2;
                if (s1 == 'v') { rs1 = item.value; }
                else if (s1 == 'l') { rs1 = item.label; }
                if (s2 == 'v') { rs2 = item.value; }
                else if (s2 == 'l') { rs2 = item.label; }
                return $("<li>")
                .append("<a>" + rs1 + " : " + rs2 + "</a>")
                .appendTo(ul);
            };
        }

    </script>
    <table width="100%" border="0" cellpadding="0" cellspacing="0">
        <tr>
            <td>
                <table border="0" align="center" cellpadding="0" cellspacing="0" style="width: 100%; height: 228px">
                    <tr>
                        <td style="height: 36px"><a href=""><font class="blklnkund"><strong>Module</strong></font></a>

                            &gt; <a href=""><font class="blklnkund"><strong>Administrator </strong></font></a>

                            &gt; <a href=""><font class="blklnkund"><strong>Business Partners</strong></font></a>

                            <font class="bluefnt"><strong>&gt; 
		  Customer Master</strong> </font></td>
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

                            <asp:UpdatePanel ID="up111" runat="server">
                                <ContentTemplate>


                                    <table border="0" cellpadding="3" width="35%" cellspacing="1" align="center" class="boxbg">
                                        <tr class="bgbluegrey">
                                            <td style="width: 54px"><font class="blackfnt">
                                                <asp:CheckBox ID="chk" runat="server" EnableViewState="true" BackColor="#D4E0E7" AutoPostBack="true" BorderColor="#D4E0E7" BorderStyle="None" BorderWidth="0px" ForeColor="#D4E0E7" Width="21px" />
              
                                            </td>
                                            <td><font class="blackfnt"><b>Active Customer</b></font></td>

                                        </tr>
                                    </table>
                                    <br />
                                    <table border="0" cellpadding="3" width="76%" cellspacing="1" align="center" class="boxbg">
                                        <tr class="bgbluegrey">
                                            <td align="center" colspan="2">
                                                <p align="center"><font class="blackfnt"><b>Quick Edit/Delete Customer</b></font></p>
                                            </td>
                                        </tr>
                                        <tr bgcolor="#FFFFFF">
                                            <td align="center" width="40%" style="height: 30px">
                                                <div align="right">
                                                    <font class="blackfnt">Enter Customer Code</font>
                                                    :
                                                </div>
                                            </td>
                                            <td bgcolor="#FFFFFF" align="left" style="height: 30px">
                                                <asp:TextBox ID="txtCstCd" runat="server" OnChange="Javascript:this.value=this.value.toUpperCase();"></asp:TextBox>
                                                <asp:Label ID="Label1" runat="server" BorderStyle="Groove" TabIndex="18" Text='<a href="javascript:nwOpen(1)">...</a>'
                                                    Width="14px"></asp:Label></td>
                                        </tr>
                                        <tr>
                                            <td bgcolor="#FFFFFF" align="center" colspan="2" height="22"><font class="blackfnt"><b>
                                                <asp:Button ID="btnQckEdit" runat="server" Text="Edit" OnClientClick="return chkCst()" OnClick="btnQckEdit_Click" />&nbsp;
            <asp:Button ID="btnQckDelete" runat="server" Text="Delete" OnClientClick="return del()" />
                                                <asp:Button ID="btnQckLstAll" runat="server" Text="ListAll" OnClick="btnQckLstAll_Click" /></b></font></td>
                                        </tr>
                                    </table>
                                    <br />
                                    <br />

                                    <table border="0" cellpadding="3" width="76%" bgcolor="#808080" cellspacing="1" align="center" class="boxbg">
                                        <tr class="bgbluegrey">
                                            <td align="center" colspan="2">
                                                <p align="center"><font class="blackfnt"><b>Select Customers for Edit/Delete</b></font></p>
                                            </td>
                                        </tr>
                                        <%--<asp:UpdatePanel ID="up1" runat="server">
                                            <ContentTemplate>--%>

                                                <tr bgcolor="#FFFFFF">
                                                    <td align="center" width="40%">
                                                        <div align="right">
                                                            <font class="blackfnt">Select Customer Group</font>
                                                            :
                                                        </div>
                                                    </td>
                                                    <td bgcolor="#FFFFFF" align="left">
                                                        <%--<asp:DropDownList ID="ddCstGrp" runat="server" AutoPostBack="True" OnSelectedIndexChanged="ddCstGrp_SelectedIndexChanged">
                                                        </asp:DropDownList>--%>
                                                        <asp:DropDownList ID="ddCstGrp" runat="server" >
                                                        </asp:DropDownList>
                                                    </td>
                                                </tr>
                                            <%--</ContentTemplate>
                                        </asp:UpdatePanel>--%>

                                        <tr bgcolor="#FFFFFF">
                                            <td align="center" valign="top">
                                                <div align="right">
                                                    <font class="blackfnt">Select Customer</font>
                                                    :
                                                </div>
                                            </td>
                                            <td bgcolor="#FFFFFF" align="left">
                                               <%-- <asp:UpdatePanel ID="up2" runat="server">
                                                    <ContentTemplate>--%>
                                                        <%--<asp:DropDownList ID="ddCst" runat="server">
                                                        </asp:DropDownList>--%>
                                                        <asp:TextBox ID="txtCustomerCode" runat="server" ></asp:TextBox>
                                                        <asp:HiddenField ID="hdnCustomerCode" runat="server" ></asp:HiddenField>
                                                    <%--</ContentTemplate>
                                                    <Triggers>
                                                        <asp:AsyncPostBackTrigger ControlID="ddCstGrp" EventName="SelectedIndexChanged" />
                                                    </Triggers>
                                                </asp:UpdatePanel>--%>
                                            </td>
                                        </tr>
                                    </table>
                                </ContentTemplate>
                            </asp:UpdatePanel>
                            <table border="0" cellpadding="3" width="76%" bgcolor="#808080" cellspacing="1" align="center" class="boxbg">
                                <tr>
                                    <td bgcolor="#FFFFFF" align="center" colspan="2" height="22">
                                        <%--<asp:UpdatePanel ID="upAdd" runat="server">
           <ContentTemplate>--%>
                                        <asp:Button ID="btnAdd" runat="server" Text="Add" OnClientClick="return chkVal()" OnClick="btnAdd_Click" />
                                        <asp:Button ID="btnEdit" runat="server" Text="Edit" OnClientClick="return chkVal2()" OnClick="btnEdit_Click" />
                                        <asp:Button ID="btnDelete" runat="server" Text="Delete" OnClientClick="return del()" />
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
    <%--</td>
        </tr>
      </table>
    </td>
  </tr>
</table>  --%>
</asp:Content>

