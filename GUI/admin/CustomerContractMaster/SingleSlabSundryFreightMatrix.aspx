<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true"
    CodeFile="SingleSlabSundryFreightMatrix.aspx.cs" Inherits="GUI_AllTest_SingleSlabSundryFreightMatrix"
    Title="Untitled Page" %>

<%@ Register Src="~/GUI/admin/CustomerContractMaster/CustContractInfo.ascx" TagName="CustInfo"
    TagPrefix="cust" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">
    <script type="text/javascript" language="javascript" src="../../images/CalendarPopup.js"></script>
    <script type="text/javascript" language="javascript" src="../../images/commonJs.js"></script>

    <script type="text/javascript" language="javascript">
        var cal = new CalendarPopup("testdiv1");
        cal.setCssPrefix("TEST");
        cal.showNavigationDropdowns();

        function CheckDate(id) {
            var FromDate = document.getElementById(id.replace("ToDate", "FromDate"));
            var ToDate = document.getElementById(id.replace("FromDate", "ToDate"));
            if (FromDate.value != "" && ToDate.value != "") {
                if (CheckFromToDate(FromDate.id, ToDate.id, true, 'C') == false) {
                    return false;
                }
            }
            return true;
        }

        function windowPopUp(mode, ctlid, tbl) {
            var winOpts = "scrollbars=yes,resizable=yes,width=" + 500 + ",height=" + 400 + "";
            var url = "";
            url = "DataPopUp.aspx?mode=" + mode + "&ctlid=" + ctlid + "&tbl=" + tbl + "&tp=4row";
            confirmWin = window.open(url, "", winOpts);
            return false;
        }


        function windowHeadPopUp(mode, ctlid, tbl, head) {
            var winOpts = "scrollbars=yes,resizable=yes,width=" + 500 + ",height=" + 400 + "";
            var url = "";
            url = "DataPopUp.aspx?mode=" + mode + "&ctlid=" + ctlid + "&tbl=" + tbl + "&tp=" + head;
            confirmWin = window.open(url, "", winOpts);
            return false;
        }

        function locTest(txtid, testtype) {
            var hdnajaxstate = document.getElementById("ctl00_MyCPH1_hdnajaxstate");
            hdnajaxstate.value = "1";

            var hdnclient = document.getElementById("ctl00_MyCPH1_hdnclient");
            var txt = document.getElementById(txtid);
            if (txt.value == "") {
                hdnajaxstate.value = "0";
                return false;
            }

            txt.value = txt.value.toUpperCase();
            var strpg = "";
            var findobj = false;
            findobj = GetXMLHttpObject();
            if (findobj) {
                if (testtype == "citytest")
                    strpg = "AjaxResponse.aspx?mode=check&code1=citytest&code2=" + txt.value + "&sid=" + Math.random() + "&sid=" + Math.random();
                else if (testtype == "loctest")
                    strpg = "AjaxResponse.aspx?mode=check&code1=loctest&code2=" + txt.value + "&sid=" + Math.random() + "&sid=" + Math.random();
                else if (testtype == "zonetest")
                    strpg = "AjaxResponse.aspx?mode=check&code1=zonetest&code2=" + txt.value + "&sid=" + Math.random() + "&sid=" + Math.random();

                findobj.open("GET", strpg);
                findobj.onreadystatechange = function () {
                    if ((findobj.readyState == 4) && (findobj.status == 200)) {
                        var res = findobj.responseText.split("|");
                        if (res[0] == "false") {
                            if (testtype == "citytest")
                                alert("City doesn't Exists...");
                            else if (testtype == "loctest")
                                alert("Location doesn't Exists...");
                            else if (testtype == "zonetest")
                                alert("Region doesn't Exists...");
                            txt.value = "";
                            txt.focus();
                            hdnajaxstate.value = "0";
                            return false;
                        }
                        else if (res[0] == "true") {
                            hdnajaxstate.value = "0";
                        }
                    }
                }

                findobj.send(null);
            }

            return true;
        }

        function submitValidation() {
            var hdnajaxstate = document.getElementById("ctl00_MyCPH1_hdnajaxstate");

            if (hdnajaxstate.value == "1") {
                alert("Let the Internal Processes over. Please wait 5-10 seconds or LogOut.");
                return false;
            }

            var cmbratetype = document.getElementById("ctl00_MyCPH1_cmbratetype");
            if (cmbratetype.value == "1" || cmbratetype.value == "0") {
                alert("Please Select Rate Type...");
                cmbratetype.focus();
                return false;
            }

            var grid = document.getElementById("ctl00_MyCPH1_grvcharges");
            var len = parseInt(grid.rows.length);
            var pref = "";
            var cnt = 0;
            for (var i = 2; i <= len; i++) {
                if (i < 10)
                    pref = "ctl00_MyCPH1_grvcharges_ctl0" + i + "_";
                else
                    pref = "ctl00_MyCPH1_grvcharges_ctl" + i + "_";

                var txtfrom = document.getElementById(pref + "txtfrom");
                var txtto = document.getElementById(pref + "txtto");
                var chkyes = document.getElementById(pref + "chkyes");

                var txtDiscountFromDate = document.getElementById(pref + "txtDiscountFromDate");
                var txtDiscountToDate = document.getElementById(pref + "txtDiscountToDate");

                if (chkyes.checked == true) {
                    cnt++;
                    if (txtfrom.value == "") {
                        alert("Please Enter From Location");
                        txtfrom.focus();
                        return false;
                    }
                    if (txtto.value == "") {
                        alert("Please Enter To Location");
                        txtto.focus();
                        return false;
                    }
                    //if (txtDiscountFromDate.value != "" || txtDiscountToDate.value == "") {
                    //    alert("Please Enter To Date");
                    //    txtDiscountToDate.focus();
                    //    return false;
                    //}
                    //if (txtDiscountToDate.value != "" || txtDiscountFromDate.value == "") {
                    //    alert("Please Enter From Date");
                    //    txtDiscountFromDate.focus();
                    //    return false;
                    //}
                    for (var j = 2; j < len; j++) {
                        var jref = "";
                        if (j < 10)
                            jref = "ctl00_MyCPH1_grvcharges_ctl0" + j + "_";
                        else
                            jref = "ctl00_MyCPH1_grvcharges_ctl" + j + "_";

                        var txtjfrom = document.getElementById(jref + "txtfrom");
                        var txtjto = document.getElementById(jref + "txtto");

                        var txtjDiscount = document.getElementById(jref + "txtDiscount");
                        var ddljDiscountType = document.getElementById(jref + "ddlDiscountType");
                        var txtjDiscountFromDate = document.getElementById(jref + "txtDiscountFromDate");
                        var txtjDiscountToDate = document.getElementById(jref + "txtDiscountToDate");

                        if (i != j) {
                            if (txtjfrom.value == "") {
                                alert("Please Enter From Location");
                                txtjfrom.focus();
                                return false;
                            }

                            if (txtjto.value == "") {
                                alert("Please Enter To Location");
                                txtto.focus();
                                return false;
                            }

                            if (parseFloat(txtjDiscount.value) > 0) {
                                if (ddljDiscountType.value == "") {
                                    alert("Please select Discount Type");
                                    ddljDiscountType.focus();
                                    return false;
                                }
                                if (txtjDiscountFromDate.value == "") {
                                    alert("Please Enter From Date");
                                    txtjDiscountFromDate.focus();
                                    return false;
                                }
                                if (txtjDiscountToDate.value == "") {
                                    alert("Please Enter To Date");
                                    txtjDiscountToDate.focus();
                                    return false;
                                }
                                //if (txtjDiscountFromDate.value != "" && txtjDiscountToDate.value == "") {
                                //    alert("Please Enter To Date");
                                //    txtjDiscountToDate.focus();
                                //    return false;
                                //}
                                //if (txtjDiscountToDate.value != "" && txtjDiscountFromDate.value == "") {
                                //    alert("Please Enter From Date");
                                //    txtjDiscountFromDate.focus();
                                //    return false;
                                //}
                            }

                            if (txtfrom.value == txtjfrom.value && txtto.value == txtjto.value) {
                                alert("No Two  pair should be same.Please Enter Another Location");
                                txtto.value = "";
                                txtto.focus();
                                return false;
                            }

                        } // i!=j

                    } //  J loop

                } // Check of YES/NO        

            } // I loop

            if (cnt == 0) {
                if (!confirm("No Record Selected. All listed data will be removed.Do you want to continue ?"))
                    return false;
            }
            return true;
        }
    </script>

    <cust:CustInfo runat="server" ID="cstheader" />
    <asp:UpdatePanel ID="upone" runat="server">
        <ContentTemplate>
            <asp:UpdatePanel runat="server" ID="updone">
                <ContentTemplate>
                    <asp:Table ID="Table1" runat="server">
                        <asp:TableRow CssClass="bgwhite">
                            <asp:TableCell ColumnSpan="2" CssClass="blackfnt">
                            Please Note : &nbsp;<font class='redfnt'>Existing Data will be Replaced, if any</font>
                            </asp:TableCell>
                        </asp:TableRow>
                        <asp:TableRow CssClass="bgwhite">
                            <asp:TableCell ColumnSpan="2" CssClass="blackfnt">
                            </asp:TableCell>
                        </asp:TableRow>
                        <asp:TableRow>
                            <asp:TableCell>
                                <asp:Table ID="Table3" HorizontalAlign="Left" runat="server" CellSpacing="1" CssClass="boxbg"
                                    Width="5in">
                                    <asp:TableRow CssClass="bgwhite">
                                        <asp:TableCell Width="50%" HorizontalAlign="Left">Matrix Type
                                        </asp:TableCell>
                                        <asp:TableCell Width="50%" HorizontalAlign="Left">
                                            <asp:Label ID="lblmatrixtype" runat="server" CssClass="blackfnt"></asp:Label>
                                        </asp:TableCell>
                                    </asp:TableRow>
                                    <asp:TableRow CssClass="bgwhite">
                                        <asp:TableCell Width="50%" HorizontalAlign="Left">Trans Mode
                                        </asp:TableCell>
                                        <asp:TableCell Width="50%" HorizontalAlign="Left">
                                            <asp:Label ID="lbltransmode" runat="server" CssClass="blackfnt"></asp:Label>
                                        </asp:TableCell>
                                    </asp:TableRow>
                                    <asp:TableRow ID="trbasedon1" runat="server" CssClass="bgwhite">
                                        <asp:TableCell Width="50%" HorizontalAlign="Left">
                                            <asp:Label ID="lblbasedon1" runat="server" CssClass="blackfnt"></asp:Label>
                                        </asp:TableCell>
                                        <asp:TableCell Width="50%" HorizontalAlign="Left">
                                            <asp:Label ID="lblbasecode1" runat="server" CssClass="blackfnt"></asp:Label>
                                        </asp:TableCell>
                                    </asp:TableRow>
                                    <asp:TableRow ID="trbasedon2" runat="server" CssClass="bgwhite">
                                        <asp:TableCell Width="50%" HorizontalAlign="Left">
                                            <asp:Label ID="lblbasedon2" runat="server" CssClass="blackfnt"></asp:Label>
                                        </asp:TableCell>
                                        <asp:TableCell Width="50%" HorizontalAlign="Left">
                                            <asp:Label ID="lblbasecode2" runat="server" CssClass="blackfnt"></asp:Label>
                                        </asp:TableCell>
                                    </asp:TableRow>
                                    <asp:TableRow CssClass="bgwhite">
                                        <asp:TableCell Width="50%" HorizontalAlign="Left">From Location Filter
                                        </asp:TableCell>
                                        <asp:TableCell Width="50%" HorizontalAlign="Left">
                                            <asp:Label ID="lblfilterfrom" runat="server" CssClass="blackfnt"></asp:Label>
                                        </asp:TableCell>
                                    </asp:TableRow>
                                    <asp:TableRow CssClass="bgwhite">
                                        <asp:TableCell Width="50%" HorizontalAlign="Left">To Location Filter
                                        </asp:TableCell>
                                        <asp:TableCell Width="50%" HorizontalAlign="Left">
                                            <asp:Label ID="lblfilterto" runat="server" CssClass="blackfnt"></asp:Label>
                                        </asp:TableCell>
                                    </asp:TableRow>
                                </asp:Table>
                                <br />
                                <br />
                            </asp:TableCell>
                        </asp:TableRow>
                        <asp:TableRow>
                            <asp:TableCell>
                                <asp:Table ID="tblmain" CellSpacing="1" CssClass="boxbg" runat="server">
                                    <asp:TableRow CssClass="bgbluegrey">
                                        <asp:TableCell ColumnSpan="2" Font-Bold="true">Sundry Single Slab Rate Type
                                        </asp:TableCell>
                                    </asp:TableRow>
                                    <asp:TableRow CssClass="bgwhite">
                                        <asp:TableCell ColumnSpan="2">
                                            <asp:DropDownList ID="cmbratetype" runat="server" CssClass="blackfnt" BackColor="white">
                                                <asp:ListItem Value="0" Text="Select"></asp:ListItem>
                                                <asp:ListItem Value="W" Text="PerKG"></asp:ListItem>
                                                <asp:ListItem Value="P" Text="PerPKG"></asp:ListItem>
                                                <asp:ListItem Value="T" Text="PerTon"></asp:ListItem>
                                            </asp:DropDownList>
                                        </asp:TableCell>
                                    </asp:TableRow>
                                    <asp:TableRow CssClass="bgbluegrey">
                                        <asp:TableCell ColumnSpan="2">
                                            <asp:Label ID="lblheader" CssClass="blackfnt" Font-Bold="true" runat="server" Text="Sundry Single Slab Rates"></asp:Label>
                                        </asp:TableCell>
                                    </asp:TableRow>
                                    <asp:TableRow CssClass="bgwhite">
                                        <asp:TableCell Width="20%">Enter No of Rows
                                        </asp:TableCell>
                                        <asp:TableCell Width="80%">
                                            <asp:TextBox ID="txtrows" Width="40px" Style="text-align: right;" onkeypress="javascript:return validInt(event)"
                                                BorderStyle="Groove" MaxLength="2" CssClass="blackfnt" runat="server"></asp:TextBox>
                                            <asp:Button ID="btnaddrows" runat="server" OnClick="btnaddrows_Click" CssClass="blackfnt"
                                                Text="Add New Rows" />
                                        </asp:TableCell>
                                    </asp:TableRow>
                                    <asp:TableRow CssClass="bgwhite">
                                        <asp:TableCell ColumnSpan="2">
                                            <asp:GridView HorizontalAlign="left" ID="grvcharges" runat="server" BorderWidth="0"
                                                CellSpacing="1" AllowSorting="true" PagerStyle-HorizontalAlign="left" CssClass="boxbg"
                                                HeaderStyle-CssClass="bgbluegrey" FooterStyle-CssClass="<%=boxbg%>"
                                                AutoGenerateColumns="false" HeaderStyle-Font-Bold="true" EmptyDataText="No Records Found..."
                                                OnRowDataBound="grvcharges_RowDataBound">
                                                <Columns>
                                                    <asp:TemplateField HeaderStyle-CssClass="blackfnt" HeaderStyle-HorizontalAlign="Center">
                                                        <ItemStyle BackColor="white" CssClass="blackfnt" HorizontalAlign="Left" />
                                                        <ItemTemplate>
                                                            <asp:CheckBox ID="chkyes" runat="server" />
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderStyle-CssClass="blackfnt" HeaderStyle-HorizontalAlign="Center">
                                                        <ItemStyle BackColor="white" CssClass="blackfnt" HorizontalAlign="Left" />
                                                        <HeaderTemplate>
                                                            From
                                                            <input type="button" id="btnfrom" runat="server" class="blackfnt" value="...." />
                                                        </HeaderTemplate>
                                                        <ItemTemplate>
                                                            <table>
                                                                <tr>
                                                                    <td>
                                                                        <asp:TextBox ID="txtfrom" Width="50px" Text='<%# DataBinder.Eval( Container.DataItem,"fromloc") %>'
                                                                            BorderStyle="Groove" CssClass="blackfnt" runat="server"></asp:TextBox>
                                                                    </td>
                                                                    <td>
                                                                        <input type="button" id="btnfrom" runat="server" class="blackfnt" value="...." />
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderStyle-CssClass="blackfnt" HeaderStyle-HorizontalAlign="Center">
                                                        <ItemStyle BackColor="white" CssClass="blackfnt" HorizontalAlign="Left" />
                                                        <HeaderTemplate>
                                                            To
                                                            <input type="button" id="btnto" runat="server" class="blackfnt" value="...." />
                                                        </HeaderTemplate>
                                                        <ItemTemplate>
                                                            <table>
                                                                <tr>
                                                                    <td>
                                                                        <asp:TextBox ID="txtto" Width="50px" Text='<%# DataBinder.Eval( Container.DataItem,"toloc") %>'
                                                                            BorderStyle="Groove" CssClass="blackfnt" runat="server"></asp:TextBox>
                                                                    </td>
                                                                    <td>
                                                                        <input type="button" id="btnto" runat="server" onclick="return false;" class="blackfnt"
                                                                            value="...." />
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:TemplateField>
                                                        <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                                        <HeaderTemplate>
                                                            Air
                                                        </HeaderTemplate>
                                                        <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                                                        <ItemTemplate>
                                                            <asp:TextBox ID="txtairrate" BorderStyle="Groove" Text='<%# DataBinder.Eval( Container.DataItem,"air_rate") %>'
                                                                onblur="javascript:return this.value=roundNumber(this.value,2)" Style="text-align: right;"
                                                                MaxLength="8" onkeypress="javascript:return validFloat(event,this.getAttribute('id'))"
                                                                Width="50px" runat="server"></asp:TextBox>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:TemplateField>
                                                        <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                                        <HeaderTemplate>
                                                            Transit Days
                                                        </HeaderTemplate>
                                                        <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                                                        <ItemTemplate>
                                                            <asp:TextBox ID="txtairdays" BorderStyle="Groove" Text='<%# DataBinder.Eval( Container.DataItem,"air_days") %>'
                                                                Style="text-align: right;" MaxLength="3" onkeypress="javascript:return validInt(event)"
                                                                Width="50px" runat="server"></asp:TextBox>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:TemplateField>
                                                        <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                                        <HeaderTemplate>
                                                            Road
                                                        </HeaderTemplate>
                                                        <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                                                        <ItemTemplate>
                                                            <asp:TextBox ID="txtroadrate" BorderStyle="Groove" Text='<%# DataBinder.Eval( Container.DataItem,"road_rate") %>'
                                                                onblur="javascript:return this.value=roundNumber(this.value,2)" Style="text-align: right;"
                                                                MaxLength="8" onkeypress="javascript:return validFloat(event,this.getAttribute('id'))"
                                                                Width="50px" runat="server"></asp:TextBox>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:TemplateField>
                                                        <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                                        <HeaderTemplate>
                                                            Transit Days
                                                        </HeaderTemplate>
                                                        <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                                                        <ItemTemplate>
                                                            <asp:TextBox ID="txtroaddays" BorderStyle="Groove" Text='<%# DataBinder.Eval( Container.DataItem,"road_days") %>'
                                                                Style="text-align: right;" MaxLength="3" onkeypress="javascript:return validInt(event)"
                                                                Width="50px" runat="server"></asp:TextBox>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:TemplateField>
                                                        <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                                        <HeaderTemplate>
                                                            Train
                                                        </HeaderTemplate>
                                                        <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                                                        <ItemTemplate>
                                                            <asp:TextBox ID="txttrainrate" BorderStyle="Groove" Text='<%# DataBinder.Eval( Container.DataItem,"train_rate") %>'
                                                                onblur="javascript:return this.value=roundNumber(this.value,2)" Style="text-align: right;"
                                                                MaxLength="8" onkeypress="javascript:return validFloat(event,this.getAttribute('id'))"
                                                                Width="50px" runat="server"></asp:TextBox>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:TemplateField>
                                                        <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                                        <HeaderTemplate>
                                                            Transit Days
                                                        </HeaderTemplate>
                                                        <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                                                        <ItemTemplate>
                                                            <asp:TextBox ID="txttraindays" BorderStyle="Groove" Text='<%# DataBinder.Eval( Container.DataItem,"train_days") %>'
                                                                Style="text-align: right;" MaxLength="3" onkeypress="javascript:return validInt(event)"
                                                                Width="50px" runat="server"></asp:TextBox>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:TemplateField>
                                                        <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                                        <HeaderTemplate>
                                                            Express
                                                        </HeaderTemplate>
                                                        <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                                                        <ItemTemplate>
                                                            <asp:TextBox ID="txtexpressrate" BorderStyle="Groove" Text='<%# DataBinder.Eval( Container.DataItem,"express_rate") %>'
                                                                onblur="javascript:return this.value=roundNumber(this.value,2)" Style="text-align: right;"
                                                                MaxLength="8" onkeypress="javascript:return validFloat(event,this.getAttribute('id'))"
                                                                Width="50px" runat="server"></asp:TextBox>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:TemplateField>
                                                        <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                                        <HeaderTemplate>
                                                            Transit Days
                                                        </HeaderTemplate>
                                                        <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                                                        <ItemTemplate>
                                                            <asp:TextBox ID="txtexpressdays" BorderStyle="Groove" Text='<%# DataBinder.Eval( Container.DataItem,"express_days") %>'
                                                                Style="text-align: right;" MaxLength="3" onkeypress="javascript:return validInt(event)"
                                                                Width="50px" runat="server"></asp:TextBox>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>

                                                    <asp:TemplateField>
                                                        <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                                        <HeaderTemplate>Discount in (%)</HeaderTemplate>
                                                        <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                                                        <ItemTemplate>
                                                            <asp:TextBox ID="txtDiscount" BorderStyle="Groove" Text='<%# DataBinder.Eval( Container.DataItem,"Discount") %>'
                                                                Style="text-align: right;" MaxLength="3" onkeypress="javascript:return validFloat(event,this.getAttribute('id'))"
                                                                Width="50px" runat="server"></asp:TextBox>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>

                                                    <asp:TemplateField>
                                                        <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                                        <HeaderTemplate>
                                                            Discount<br />
                                                            Rate Type
                                                        </HeaderTemplate>
                                                        <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                                                        <ItemTemplate>
                                                            <asp:DropDownList ID="ddlDiscountType" runat="server" CssClass="ddlm"
                                                                DataTextField="CodeDesc" DataValueField="CodeId">
                                                                <%-- <asp:ListItem Text="Select" Value="" />
                                                                <asp:ListItem Text="Basic Freight" Value="B" />
                                                                <asp:ListItem Text="Flat" Value="F" />--%>
                                                            </asp:DropDownList>
                                                            <asp:HiddenField ID="hdnDiscountType" runat="server" Value='<%# DataBinder.Eval(Container.DataItem,"DiscountType") %>' />
                                                        </ItemTemplate>
                                                    </asp:TemplateField>

                                                    <asp:TemplateField>
                                                        <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                                        <HeaderTemplate>Valid From Date</HeaderTemplate>
                                                        <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                                                        <ItemTemplate>
                                                            <asp:TextBox ID="txtDiscountFromDate" runat="server" MaxLength="10" CssClass="blackfnt" Width="75px" BorderStyle="Groove"
                                                                Text='<%# DataBinder.Eval(Container.DataItem,"DiscountFromDate") %>'
                                                                onkeypress="javascript:return withoutQuote(event)"
                                                                onblur="Javascipt:return CheckDate(this.getAttribute('id'))" />
                                                            <asp:LinkButton ID="lnkDiscountFromDate" runat="server">
                                                                <img src="../../images/calendar.jpg" alt="calendar.jpg" border="0"></a>
                                                            </asp:LinkButton>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:TemplateField>
                                                        <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                                        <HeaderTemplate>Valid To Date</HeaderTemplate>
                                                        <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                                                        <ItemTemplate>
                                                            <asp:TextBox ID="txtDiscountToDate" runat="server" MaxLength="10" CssClass="blackfnt" Width="75px" BorderStyle="Groove"
                                                                Text='<%# DataBinder.Eval(Container.DataItem,"DiscountToDate") %>'
                                                                onkeypress="javascript:return withoutQuote(event)"
                                                                onblur="Javascipt:return CheckDate(this.getAttribute('id'))" />
                                                            <asp:LinkButton ID="lnkDiscountToDate" runat="server">
                                                                <img src="../../images/calendar.jpg" alt="calendar.jpg" border="0"></a>
                                                            </asp:LinkButton>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                </Columns>
                                            </asp:GridView>
                                        </asp:TableCell>
                                    </asp:TableRow>
                                    <asp:TableRow CssClass="bgbluegrey">
                                        <asp:TableCell ColumnSpan="2">
                                            <asp:Button ID="btnsubmit" CssClass="blackfnt" Text="Submit" runat="server" OnClick="btnsubmit_Click"
                                                OnClientClick="javascript:return submitValidation()" />
                                        </asp:TableCell>
                                    </asp:TableRow>
                                </asp:Table>
                            </asp:TableCell>
                        </asp:TableRow>
                    </asp:Table>
                    <asp:HiddenField ID="hdncontractid" runat="server" />
                    <asp:HiddenField ID="hdncustcode" runat="server" />
                    <asp:HiddenField ID="hdncontracttype" runat="server" />
                    <asp:HiddenField ID="hdnmatrixtype" runat="server" />
                    <asp:HiddenField ID="hdntransmode" runat="server" />
                    <asp:HiddenField ID="hdnajaxstate" runat="server" />
                    <asp:HiddenField ID="hdnfrom" runat="server" />
                    <asp:HiddenField ID="hdnto" runat="server" />
                    <asp:HiddenField ID="hdnbasedon1" runat="server" />
                    <asp:HiddenField ID="hdnbasecode1" runat="server" />
                    <asp:HiddenField ID="hdnbasedon2" runat="server" />
                    <asp:HiddenField ID="hdnbasecode2" runat="server" />
                </ContentTemplate>
            </asp:UpdatePanel>
            <asp:UpdateProgress ID="uppMain" runat="server">
                <ProgressTemplate>
                    <table style="border: solid #8ba0e5 2px; z-index: 98; position: fixed; width: 200px; -left: -60px; top: 50%; left: 40%;"
                        width="190px" cellpadding="0" bgcolor="white">
                        <tr>
                            <td align="right">
                                <img src="../../images/loading.gif" alt="" />
                            </td>
                            <td>
                                <font face="verdana" color="#0000ff" size="2">&nbsp;&nbsp;&nbsp;<b>Please Wait ...</b></font>
                            </td>
                        </tr>
                    </table>
                    <asp:Panel ID="Panel1" Style="position: fixed; z-index: 97; top: 0px; left: 0px; background-color: #FFFFFF; width: 100%; height: 100%; filter: Alpha(Opacity=50); opacity: .50; -moz-opacity: .50;"
                        runat="server">
                        <asp:Panel Style="z-index: 98; position: fixed; width: 120px; -left: -60px; top: 50%; left: 50%;"
                            ID="Panel2" runat="server">
                        </asp:Panel>
                    </asp:Panel>
                </ProgressTemplate>
            </asp:UpdateProgress>
        </ContentTemplate>
    </asp:UpdatePanel>
    <div id="testdiv1" style="position: absolute; visibility: hidden; background-color: white; z-index: 99;">
    </div>
</asp:Content>
